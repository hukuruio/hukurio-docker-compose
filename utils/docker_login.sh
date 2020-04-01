#!/usr/bin/env bash

echo ${DOCKER_HUB_TOKEN} | docker login -u ${DOCKER_USERNAME} --password-stdin
