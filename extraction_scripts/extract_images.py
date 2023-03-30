import os
import subprocess

from dotenv import load_dotenv
from roboflow import Roboflow
from minio import Minio
from minio.error import InvalidResponseError

dir = os.path.dirname(__file__)
parent_dir = os.path.dirname(dir)

dotenv_path = os.path.join(dir, '..', '..', '.env')

load_dotenv(dotenv_path)

API_KEY = os.getenv('api_private_key')
MINIO_ROOT_USER = os.getenv('MINIO_ROOT_USER')
MINIO_ROOT_PASSWORD = os.getenv('MINIO_ROOT_PASSWORD')

rf = Roboflow(api_key=f'{API_KEY}')
project = rf.workspace('lucascustodio').project('pothole-abrol')
dataset = project.version(1).download('coco')
name = dataset.name + '-' + dataset.version

# subprocess.run(f"mv -f {name}/ data/my-bucket/", shell=True)

# Set up Minio client
minio_client = Minio(
    'minio:9000',
    access_key=f'{MINIO_ROOT_USER}',
    secret_key=f'{MINIO_ROOT_PASSWORD}',
    secure=False
)

for root, _, files in os.walk(f'{name}'):
    for file in files:
        file_path = os.path.join(root, file)
        object_name = os.path.relpath(file_path, parent_dir)

        try:
            minio_client.fput_object('my-bucket', object_name, file_path)
        except InvalidResponseError as err:
            print(err)