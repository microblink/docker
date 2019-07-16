This are only the `Dockerfile` and `docker-compose.yml` implementations.  

Application sources for Microblink API written in Java and OCR engine in C++ are private and not available as open-source.  

# Docs

The whole documentation how to configure and run Docker Image `microblink/api` is available on Docker Hub description at https://hub.docker.com/r/microblink/api

# Docker Compose templates

[Microblink API](./docker-compose.api.yml)  

[Nginx proxy and Let's Encrypt certificate obtainer](./docker-compose.webproxy.yml)  

# Setup

It is recommended to run the application with Nginx proxy and Basic authentication with Docker Compose but it is possible to host application directly by exposing port 8080 from the Microblink's API container.  

## Run

#### Development

`-it` is used for interactive mode.  
`--rm` is used to be removed when the container is stopped.  

`docker run -it --rm -p 0.0.0.0:8080:8080 -e "LICENSEE=xxxx" -e "LICENSE_KEY=xxxx" microblink/api`

#### Production

`-d` is used to be executed as a background process.  
`--restart unless-stopped` is used as protection to be automatically restarted if a container is down.   

`docker run -d --restart unless-stopped --name microblink-api -p 80:8080 -p 443:8080 -e "LICENSEE=xxxx" -e "LICENSE_KEY=xxxx" microblink/api:1.17.1`

## Docker Compose

### Standalone run

`docker-compose up` with `docker-compose.yml`

### Behind Nginx webproxy and with Let's encrypt 

Run web proxy with separate Docker Compose configuration with `docker-compose -f docker-compose.webproxy.yml` and then run as standalone run.

## Docker Swarm

When application is run on the Swarm node it is possible to store credentials (`LICENSEE` and `LICENSE_KEY`) to the Docker secrets, and then use Docker Compose configuration `docker-compose.swarm.yml`.

### Steps

1. Initialize Swarm cluster:  
  `docker swarm init`
  
2. Create secrets MICROBLINK_LICENSEE and MICROBLINK_LICENSE_KEY:  
  `echo "myLicensee" | docker secret create MICROBLINK_LICENSEE -`   
  `echo "myLicenseKey" | docker secret create MICROBLINK_LICENSE_KEY -`   
  
3. Run stack service:  
  `docker stack deploy -c docker-compose.swarm.yml microblink-api-stack`
  
4. View logs on running container:  
  `docker logs $(docker ps | grep microblink-api-stack | awk  '{print $1}')`


# Tutorial

This is the step by step guide how to host application on EC2 instance on Amazon Web services.  

The tutorial includes instance setup, Docker and Docker Compose installation, SWAP disk creation, DNS management with Cloudflare and application run with NGINX proxy and automatic Let's Encrypt SSL obtainer.

<p align="center" >
  <a href="https://youtu.be/kIR4SVRSa9U" target="_blank">
    <img src="https://raw.githubusercontent.com/microblink/docker/83c07acda6f15765b47e8f90f8335cac52105713/api/tutorial_aws.gif" alt="Video tutorial" />
  </a>
  <a href="https://vimeo.com/242042478" target="_blank">Watch the full tutorial on Vimeo</a>
  <a href="https://youtu.be/uSMc5ELC6f8" target="_blank">Watch the full tutorial on YouTube</a>
</p>
