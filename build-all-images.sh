#!/usr/bin/env bash

for image in java8 zookeeper kafka kudu drill hadoop
do
    cd $image
    sudo docker build -t eskabetxe:$image .
    cd ..
done

sudo docker-compose build
sudo docker-compose up
