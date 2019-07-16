# Microblink's Custom Docker images

## Images

### microblink/java

Open source custom Java runtime based on Alpine Linux and OpenJDK, it is the `BASE` image for `microblink/api`, more details at https://github.com/microblink/docker-microblink-java

### microblink/api

Docker Image with source in [api](./api). This image is based on `microblink/java`. Image is available as [microblink/api](https://hub.docker.com/r/microblink/api) on Docker Hub. It is used to host Microblink API on-premise on any Linux machine where Docker is available. It is Spring Java application with compiled Microblink OCR engine and it is possible to run only with the custom licensee and license key which should be provided by Microblink Sales Team, to get more details please send email to sales@microblink.com  

Get more details about `microblink/api` in standalone [README](./api).
