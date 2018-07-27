#!/usr/bin/env bash

for image in kudu
do
    cd $image
    sudo docker build -t eskabetxe:$image .
    cd ..
done

sudo docker-compose build
sudo docker-compose up
