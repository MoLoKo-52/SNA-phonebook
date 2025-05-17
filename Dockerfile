FROM python:3.10-slim
WORKDIR /app

COPY server/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY server/ .

EXPOSE 50051
CMD ["python", "server.py"]