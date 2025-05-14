# Phonebook gRPC System

## Server setup

### Install Dependencies


```bash
cd server
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### If `phonebook_pb2.py` and `phonebook_pb2_grpc.py` are missing, generate them using:

```bash
python -m grpc_tools.protoc -I../proto --python_out=. --grpc_python_out=. ../proto/phonebook.proto
```

### Run the server

```bash
python server.py
```

## Flutter Client setup

## Download the build application

[Android (.apk)](https://github.com/MoLoKo-52/Phone-book/releases/download/mvp/app-release.apk)

[MacOS](https://github.com/MoLoKo-52/Phone-book/releases/download/mvp/Runner.app.zip)


## Connect to the server

Click on the settings icon and write there IP of the host mashine  
You can check it by command in terminal:

```bash
ifconfig
```

Then click apply and the status should become "connected"
