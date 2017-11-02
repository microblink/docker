#!/bin/bash
docker build . -t microblink/builder:latest -t microblink/builder:1.0
docker push microblink/builder:latest
docker push microblink/builder:1.0