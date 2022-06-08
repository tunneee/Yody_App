from google.cloud import storage
from os.path import dirname, join
from dotenv import load_dotenv
from google.oauth2 import service_account

credentials = service_account.Credentials.from_service_account_file(
    'C:\\Users\\ASUS\\Desktop\\Git\\project6\\emotion_tracking\\database\\GoogleKey.json')

import os

dotenv_path = join(dirname(__file__), '.env')
load_dotenv(dotenv_path)
GG_KEY = os.environ.get("FB")
# Imports the Google Cloud client library

# Instantiates a client

def download_blob(bucket_name, source_blob_name, destination_file_name):
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(source_blob_name)
    blob.download_to_filename(destination_file_name)

    print(
        "Downloaded storage object {} from bucket {} to local file {}.".format(
            source_blob_name, bucket_name, destination_file_name
        )
    )
def bucket_metadata(bucket_name):
    """Prints out a bucket's metadata."""
    # bucket_name = 'your-bucket-name'

    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucket_name)

    print(f"ID: {bucket.id}")
    print(f"Name: {bucket.name}")
    print(f"Storage Class: {bucket.storage_class}")
    print(f"Location: {bucket.location}")
    print(f"Location Type: {bucket.location_type}")
    print(f"Cors: {bucket.cors}")
    print(f"Default Event Based Hold: {bucket.default_event_based_hold}")
    print(f"Default KMS Key Name: {bucket.default_kms_key_name}")
    print(f"Metageneration: {bucket.metageneration}")
    print(
        f"Public Access Prevention: {bucket.iam_configuration.public_access_prevention}"
    )
    print(f"Retention Effective Time: {bucket.retention_policy_effective_time}")
    print(f"Retention Period: {bucket.retention_period}")
    print(f"Retention Policy Locked: {bucket.retention_policy_locked}")
    print(f"Requester Pays: {bucket.requester_pays}")
    print(f"Self Link: {bucket.self_link}")
    print(f"Time Created: {bucket.time_created}")
    print(f"Versioning Enabled: {bucket.versioning_enabled}")
    print(f"Labels: {bucket.labels}")
def implicit():
    # If you don't specify credentials when constructing the client, the
    # client library will look for credentials in the environment.
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"]='C:\\Users\\ASUS\\Desktop\\Git\\project6\\emotion_tracking\\database\\GoogleKey.json'
    storage_client = storage.Client(credentials=credentials)

    # Make an authenticated API request
    buckets = list(storage_client.list_buckets())
    print(buckets)

implicit()
# bucket_name = "yody-app.appspot.com"
# blob_name = "48XTOwsH71M62uNHQQrTv5i7gXJ3"
# save_dir = u"C:\\Users\\ASUS\\Desktop\\Git\\project6\\emotion_tracking\\database"

# download_blob()