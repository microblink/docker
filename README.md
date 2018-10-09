# Microblink's Custom Docker images

## Images

### Base

Docker Image with source in [base](./base). This image is based on Ubuntu and has Oracle JDK, GLIBC. Image is available as [microblink/base](https://hub.docker.com/r/microblink/base) on Docker Hub.

### Api

Docker Image with source in [api](./api). This image is based on `microblink/base`. Image is available as [microblink/api](https://hub.docker.com/r/microblink/api) on Docker Hub. It is used host Microblink Web API on premise on any Linux machine where Docker is available. It is Spring Java application with compiled Microblink OCR engine and it is possible to run only with custom licence key which should be provided by Microblink Sales team, to get more details please send email to sales@microblink.com. 

Get more details about `microblink/api` in standalone [README](./api).
