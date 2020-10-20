import sys

import boto3
import os


LOCAL_CACHE = '/s3/SAR-Intensity/'


if __name__ == '__main__':
    s3_path = sys.argv[1].strip()
    
    client = boto3.client('s3')

    if s3_path[-1] == '/':
        rc = os.system(f'aws s3 cp {s3_path} {LOCAL_CACHE} --recursive')
    else:
        rc = os.system(f'aws s3 cp {s3_path} {LOCAL_CACHE}')

    if rc != 0:
        print('encountered error pulling from s3')
        sys.exit(0)

    print(f'Successfully downloaded "{s3_path}" to {LOCAL_CACHE}')
