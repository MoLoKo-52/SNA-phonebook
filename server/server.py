import grpc
from concurrent import futures
import json
import hmac
import hashlib
from . import phonebook_pb2, phonebook_pb2_grpc

SECRET_KEY = b'righ;odihfghio'  # Key used for HMAC signature generation
PHONEBOOK: dict = {}            # Raw phonebook data loaded from file
norm_map: dict = {}             # Normalized name-to-number mapping for flexible lookup

# Loads phonebook data from JSON file and builds a normalized lookup map
def load_phonebook(path: str):
    global PHONEBOOK, norm_map
    with open(path, "r", encoding="utf-8") as f:
        PHONEBOOK = json.load(f)

    norm_map = {}
    for fullname, number in PHONEBOOK.items():
        parts = fullname.strip().lower().split()
        key = " ".join(parts)           # Normalize: lowercase and remove extra spaces
        norm_map[key] = number
        if len(parts) == 2:
            swapped = " ".join(reversed(parts))  # Support "Last First" or "First Last"
            norm_map[swapped] = number

# Creates and returns a gRPC server with a thread pool
def create_server(max_workers: int = 10) -> grpc.Server:
    return grpc.server(futures.ThreadPoolExecutor(max_workers=max_workers))

# Performs a name lookup in the normalized map
def lookup(name: str) -> str:
    parts = name.strip().lower().split()
    key = " ".join(parts)
    return norm_map.get(key, "")

# Generates a secure HMAC signature for the response
def generate_signature(name: str, number: str, found: bool) -> str:
    msg = f"{name}:{number}:{found}".encode()
    return hmac.new(SECRET_KEY, msg, hashlib.sha256).hexdigest()

# gRPC service implementation class
class PhonebookServicer(phonebook_pb2_grpc.PhonebookServiceServicer):
    # Handles GetNumberByName RPC request
    def GetNumberByName(self, request, context):
        raw = request.name
        number = lookup(raw)
        found = bool(number)
        signature = generate_signature(raw, number, found)
        return phonebook_pb2.NumberResponse(
            name=raw,
            number=number,
            found=found,
            signature=signature
        )

# Entry point: loads data, starts and runs the gRPC server
def serve():
    print("Loading phonebook...")
    load_phonebook("data.json")

    print("Starting server...")
    server = create_server(max_workers=10)
    phonebook_pb2_grpc.add_PhonebookServiceServicer_to_server(
        PhonebookServicer(), server
    )
    port = server.add_insecure_port("0.0.0.0:50051")
    print(f"Bound to port: {port}")
    server.start()
    server.wait_for_termination()

if __name__ == "__main__":
    serve()