#!/bin/bash
docker build . -t microblink/base:latest -t microblink/base:1.0
docker push microblink/base:latest
docker push microblink/base:1.0