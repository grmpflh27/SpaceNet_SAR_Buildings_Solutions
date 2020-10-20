#!/usr/bin/env bash
S3_PATH=$1
ARG2=${2:-/wdata/solution.csv}

mkdir -p /s3/SAR-Intensity/
rm -rf /s3/SAR-Intensity/*

python pull_from_s3.py $S3_PATH

mkdir -p /wdata/segmentation_logs/ /wdata/folds_predicts/

if [ "$(ls -A /wdata/segmentation_logs/)" ]; then
     echo "trained weights available"
else
    echo "loading pretrained weights"
    mkdir -p /wdata/segmentation_logs/8_3_reduce_1_unet_senet154/checkpoints/
    gdown https://drive.google.com/uc?id=15YTIHPA4hs2tJMFXP0q_2y2B_-UmaQl0 -O /wdata/segmentation_logs/8_3_reduce_1_unet_senet154/checkpoints/best.pth
fi


python3 /project/predict/predict.py --config_path /project/configs/senet154_gcc_fold1.py --gpu '"0"' --test_images /s3 --workers 16 --batch_size 16

python3 /project/predict/submit.py --submit_path $ARG2

# copying over to s3
dateStr=`date --iso-8601=seconds | sed 's/+00:00//' | tr -d ':' | tr -d '-'`

targetS3="s3://capella-data-science-temp/${dateStr}/"
aws s3 cp /wdata/folds_predicts/8_3_reduce_1_unet_senet154/ $targetS3 --recursive
aws s3 cp $ARG2 $targetS3

echo "Copied to ${targetS3}"

echo "Issue the following to pull"
echo "aws s3 cp $targetS3 . --recursive"