FROM python:3.9-slim-buster

RUN apt-get update && apt-get install -y libgl1-mesa-glx && apt-get install -y libglib2.0-0

COPY requirements.txt  .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .