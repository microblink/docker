This is the `Dockerfile` and `docker-compose.yml` implementation but Microblink API Java and C++ is private and not available for the public. 

# Tutorial 

This is the step by step guide how to host application on EC2 instance on Amazon Web services.  

Tutorial includes instance setup, Docker and Docker Compose installation, SWAP disk creation, DNS management with Cloudflare and application run with NGINX proxy and automatic Let's Encrypt SSL obtainer.

<p align="center" >
  <a href="https://youtu.be/kIR4SVRSa9U" target="_blank">
    <img src="https://raw.githubusercontent.com/" alt="Video tutorial" />
  </a>
  <a href="https://vimeo.com/241867174" target="_blank">Watch on Vimeo</a>
  <a href="https://youtu.be/kIR4SVRSa9U" target="_blank">Watch on YouTube</a>
</p>

# Docker Compose templates

[Nginx proxy, Let's Encrypt certificate obtainer and Microblink API](./docker-compose.yml)  

[Nginx proxy and Let's Encrypt certificate obtainer](./docker-compose.nginx.yml)  

[Microblink API](./docker-compose.api.yml)  
 

# Setup

It is recommended to run application with Nginx proxy and Basic authentication with Docker Compose but it is possible to host application directly with exposing port 8080 from the container. 

## ENV variables

### Required

`LICENSEE` should be an String and it is required, licensee should be explicitly set because licence key should have support for multiple apps because Docker image could be horizontally scaled across multiple servers with different licensees.  

`LICENCE_KEY` should be an String and it is required, without set correct licence key application would not be started. Licence key should be generated for `platform=Linux`, `product=BlinkIDCore`, `version>=3.1` and `licensee=XXX`.  

#### Optional

`DEFAULT_NUMBER_OF_WORKERS` should be an Integer and recommended number of workers are number of machine's CPUs (number of cores or twice number of cores if processor support Hyper-threading technology). If not set default value "2" will be used.  

`TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED` should be an Integer and this is the number after how many executed tasks worker should be and retired (stopped process) and started fresh Native wrapper, this is protection against potential memory leaks which can cause application unavailability. If not set default value "200" will be used.  

`MINUTES_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED` should be an Integer and this is the number after how many minutes the worker should be and retired (stopped process) and started fresh Native wrapper, this is protection against potential memory leaks which can cause application unavailability. If not set default value "120" will be used.

`PING_IS_ENABLED` should be an Boolean, by default is true if it is set to false than PING server will not be notified.  

`PING_PERIOD_TASKS` should be an positive Integer, by default is 100 and this is the number when PING server will be notified, after how many executed tasks.  

## Run

#### Development

`-it` is used for interactive mode.  
`--rm` is used to be removed when container is stopped.  

```bash
docker run -it --rm -p 0.0.0.0:8080:8080 -e "LICENSEE=xxxx" -e "LICENCE_KEY=xxxx" -e "DEFAULT_NUMBER_OF_WORKERS=5" -e "TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=3" microblink/api
```

#### Production

`-d` is used to be executed as background process.  
`--restart unless-stopped` is used as protection to be automatically restarted if container is down.   

```bash
docker run -d --restart unless-stopped --name microblink-api -p 80:8080 -p 443:8080 -e "LICENSEE=xxxx" -e "LICENCE_KEY=xxxx" -e "DEFAULT_NUMBER_OF_WORKERS=8" -e "TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=200" -e "MINUTES_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=120" microblink/api:1.0.0
```