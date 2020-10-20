#! /usr/bin/env

S3_PATH=$1
if [ $# -eq 0 ]; then
    echo "Please provide s3 prefix"
    exit 1
fi


docker run -it --runtime=nvidia --ipc=host -v ${ARG1}:/data spacenet6:2-MaksimovKA sh test_from_s3.sh $S3_PATH