import boto3
import logging
from datetime import datetime

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)
S3_CLIENT = boto3.client('s3', endpoint_url='http://localhost:4572')

def handler(event, context):
    LOGGER.info('I\'m putting something in S3')
    test_object_key = 'a-object-{0}'.format(datetime.now().isoformat())
    S3_CLIENT.put_object(
        Bucket='dap-test-local-bucket',
        Key=test_object_key,
        Body='some body'
    )
    return {
        "message": "{0} placed into S3".format(test_object_key)
    }
