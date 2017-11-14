#!/bin/bash
VERSION="1.0"
docker build . -t microblink/builder:latest -t microblink/builder:$VERSION
docker push microblink/builder:latest
docker push microblink/builder:$VERSION