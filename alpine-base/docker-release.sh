#!/bin/bash
docker build . -t microblink/alpine-base:latest -t microblink/alpine-base:1.0
docker push microblink/alpine-base:latest
docker push microblink/alpine-base:1.0