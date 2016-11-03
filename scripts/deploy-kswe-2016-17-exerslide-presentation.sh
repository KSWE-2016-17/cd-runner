#!/bin/bash

cd $(dirname $(realpath $0))/deploy-kswe-2016-17-exerslide-presentation

docker-compose up -d --force-recreate
