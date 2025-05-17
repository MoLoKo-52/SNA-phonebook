import pytest
import grpc
import server.server as srv

def test_create_server_has_expected_methods():
    server_obj = srv.create_server(max_workers=2)
    assert hasattr(server_obj, "add_insecure_port"), "нет метода add_insecure_port"
    assert hasattr(server_obj, "start"), "нет метода start"
    assert hasattr(server_obj, "wait_for_termination"), "нет метода wait_for_termination"

def test_generate_signature_returns_64_hex_chars():
    sig = srv.generate_signature("Alice","12345", True)
    assert isinstance(sig, str)
    assert len(sig) == 64
    int(sig, 16) 

def test_lookup_known_and_unknown():
    srv.norm_map = {
        "john doe": "111",
        "doe john": "111",
    }
    assert srv.lookup("John Doe") == "111"
    assert srv.lookup("Doe John") == "111"
    assert srv.lookup("Nobody") == ""