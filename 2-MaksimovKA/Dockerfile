FROM catalystteam/catalyst:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y wget htop mc

RUN conda install -y gdal

COPY ./requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt

RUN mkdir /project
COPY ./ /project/

RUN chmod +x /project/train.sh
RUN chmod +x /project/test.sh
WORKDIR /project

# bake in model
RUN mkdir -p /wdata/segmentation_logs/8_3_reduce_1_unet_senet154/checkpoints/ \
  && gdown https://drive.google.com/uc?id=15YTIHPA4hs2tJMFXP0q_2y2B_-UmaQl0 -O /wdata/segmentation_logs/8_3_reduce_1_unet_senet154/checkpoints/best.pth

ENV PYTHONPATH "${PYTHONPATH}:/project"
ENV TORCH_HOME="/wdata/pretrained_models/"