#! /usr/bin/env

ARG1=${1:-$HOME/data/}

docker run -it --runtime=nvidia --ipc=host -v ${ARG1}:/data spacenet6:2-MaksimovKA sh test.sh /data