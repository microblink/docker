This are only the `Dockerfile` and `docker-compose.yml` implementations.  

Application sources for Microblink API written in Java and OCR engine in C++ are private and not available as open-source.

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


# Docker Compose templates

[Microblink API](./docker-compose.api.yml)  

[Nginx proxy and Let's Encrypt certificate obtainer](./docker-compose.webproxy.yml)  

# Setup

It is recommended to run the application with Nginx proxy and Basic authentication with Docker Compose but it is possible to host application directly by exposing port 8080 from the Microblink's API container. 

## ENV variables

### Required

`LICENSEE` should be a String and it is required, a licensee should be explicitly set because license key should have support for multiple apps because Docker image could be horizontally scaled across multiple servers with different licensees.  

`LICENSE_KEY` should be a Base64 String and it is required, without set correct license key application would not be started. License key should be generated for `platform=Linux`, `product=MicroblinkCore`, `version>=1.0` and `licensee=XXX`.   

#### Optional

`DEFAULT_NUMBER_OF_WORKERS` should be an Integer and recommended a number of workers are a number of machine's CPUs (number of cores or twice the number of cores if processor support Hyper-threading technology). If not set default value "2" will be used.  

`TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED` should be an Integer and this is the number after how many executed tasks worker should be and retired (the stopped process) and started fresh Native wrapper, this is protection against potential memory leaks which can cause application unavailability. If not set default value "200" will be used.  

`MINUTES_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED` should be an Integer and this is the number after how many minutes the worker should be and retired (stopped process) and started fresh Native wrapper, this is protection against potential memory leaks which can cause application unavailability. If not set default value "120" will be used.

`PING_IS_ENABLED` should be a Boolean, by default is true if it is set to false than PING server will not be notified.  

`PING_PERIOD_TASKS` should be a positive Integer, by default is 100 and this is the number when PING server will be notified, after how many executed tasks.  

## Run

#### Development

`-it` is used for interactive mode.  
`--rm` is used to be removed when the container is stopped.  

`docker run -it --rm -p 0.0.0.0:8080:8080 -e "LICENSEE=xxxx" -e "LICENSE_KEY=xxxx" -e "DEFAULT_NUMBER_OF_WORKERS=5" -e "TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=3" microblink/api`

#### Production

`-d` is used to be executed as a background process.  
`--restart unless-stopped` is used as protection to be automatically restarted if a container is down.   

`docker run -d --restart unless-stopped --name microblink-api -p 80:8080 -p 443:8080 -e "LICENSEE=xxxx" -e "LICENSE_KEY=xxxx" -e "DEFAULT_NUMBER_OF_WORKERS=8" -e "TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=200" -e "MINUTES_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=120" microblink/api:1.5.0`

## Docker Compose

### Standalone run

`docker-compose up` with `docker-compose.yml`

### Behind Nginx webproxy and with Let's encrypt 

Run web proxy with separate Docker Compose configuration with `docker-compose -f docker-compose.webproxy.yml` adn then run as standalone run.

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
