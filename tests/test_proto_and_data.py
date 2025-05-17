import json
from pathlib import Path
import pytest

import server.phonebook_pb2 as pb2
import server.phonebook_pb2_grpc as pb2_grpc

def test_proto_modules_importable():
    assert hasattr(pb2, 'DESCRIPTOR'), "phonebook_pb2.DESCRIPTOR не найден"
    assert hasattr(pb2_grpc, 'PhonebookServiceServicer'), \
        "phonebook_pb2_grpc.PhonebookServiceServicer не найден"
    assert hasattr(pb2_grpc, 'PhonebookServiceStub'), \
        "phonebook_pb2_grpc.PhonebookServiceStub не найден"

def test_proto_service_name():
    services = pb2.DESCRIPTOR.services_by_name
    assert services, f"Нет ни одного сервиса в phonebook_pb2: {services}"

def test_data_json_structure():
    data_path = Path(__file__).parent.parent / 'server' / 'data.json'
    assert data_path.exists(), f"{data_path} не найден"
    raw = data_path.read_text(encoding='utf-8')
    data = json.loads(raw)

    assert isinstance(data, dict), "data.json должен быть объектом JSON"
    for k, v in data.items():
        assert isinstance(k, str), f"Ключ {k!r} не строка"
        assert isinstance(v, str), f"Значение для {k!r} не строка"