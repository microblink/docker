FROM microblink/java:13
LABEL maintainer="Matija Stepanic <matija.stepanic@microblink.com>" version="3.1"

###############################################################
# ENVIRONMENT VARIABLES
###############################################################

# ------------------------------------------------------
## REQUIRED
# ---------
### Licensing credentials for OCR engine
ENV LICENSEE=""
ENV LICENSE_KEY=""
# ------------------------------------------------------

# ------------------------------------------------------
## OPTIONAL
# ---------
### Protect application with basic HTTP authentication, by default is disabled (application is open)
ENV BASIC_AUTH_USERNAME="#{null}"
### Password should be a BCrypt hash, to security issues with exposing the application's password as plain text
ENV BASIC_AUTH_PASSWORD="#{null}"
### Limit image upload size, by default is disabled (unlimited)
ENV MICROBLINK_IMAGE_SIZE_LIMIT_IN_MB="#{null}"
# ---------
### Flexible setup of other custom options to the Java Spring Boot application, by default there are no additional options
ENV JAVA_OPTS=""

# EXAMPLES

## Increase Java Max heap size
## NOTE: do not set this value to more than 90% available RAM memory on the machine, to avoid unexpected application crashes
### ENV JAVA_OPTS="-Xmx6g"

## Make application available at https protocol
### ENV JAVA_OPTS="-Dserver.ssl.enabled=true"
### ENV JAVA_OPTS="-Dserver.ssl.enabled=true -Dserver.ssl.key-store-type=PKCS12 -Dserver.ssl.key-store=/custom/mounted/path/my-custom-keystore.p12 -Dserver.ssl.key-store-password=my-custom-keytore-password -Dserver.ssl.key-alias=custom-key-alias"

## Change application timezone, default time zone is container timezone, default container timezone is timezone set on the Docker's host machine this value will be timezone in the application logs
### ENV JAVA_OPTS="-Duser.timezone=Europe/Zagreb"

## Multiple options
### NOTE: do not set JAVA_OPTS more than once, all options should be defined with one command, otherwise only the last definition will be used
### ENV JAVA_OPTS="-Dserver.ssl.enabled=true -Xmx6g -Duser.timezone=Europe/Zagreb"
# ------------------------------------------------------

# ------------------------------------------------------
## ADVANCED
# ---------
### Not allowed to change! Changing these values without written approval from Microblink can cause insufficient support! 

## WORKERS - OCR engine
# 2 workers are ideal combination, because 1 worker with multiple requests uses about 50% of available CPUs
ENV DEFAULT_NUMBER_OF_WORKERS=2
ENV TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=1000
ENV MINUTES_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=1440
ENV EXECUTION_QUEUE_CAPACITY=500
ENV EXECUTION_TIMEOUT_IN_SECONDS=60
## PING SERVER - OCR statistic
ENV PING_IS_ENABLED=true
ENV PING_PERIOD_TASKS=100
## MLS - OCR example collector
ENV MLS_IS_ENABLED=false
## SaaS custom authentication with apiKey/apiSecret
ENV MICROBLINK_IDENTITY_IS_ENABLED=false
ENV MICROBLINK_IDENTITY_SERVER_URL=https://api.microblink.com/id
ENV MICROBLINK_IDENTITY_CONSUMER_AUTHENTICATION_HEADER=""
## SaaS update apiKey balance
ENV MICROBLINK_IDENTITY_CONSUME_BATCH_WHEN_ACCUMULATED_EXECUTIONS_ARE_MORE_THAN=100
ENV MICROBLINK_IDENTITY_CONSUME_BATCH_WHEN_HOW_MANY_SECONDS_SINCE_LAST_CONSUMING=60
## Hide full OCR result for non authenticated users
ENV MICROBLINK_IDENTITY_IS_ENABLED_AND_AUTHORIZATION_IS_MISSING_IS_MASKING_RESULTS_ENABLED=false
ENV MAX_VISIBLE_MASKED_CHARACTERS_PER_PROPERTY=10
ENV MAX_VISIBLE_MASKED_PERCENTAGE_OF_PROPERTY=0.4
## Java Spring environment
ENV ENVIRONMENT="docker"
## TCP port on which application will be available...
# ...on the host machine
EXPOSE 8080
# ...in the container
ENV PORT=8080
# expose and the internal port should be the same

# Sufix to the entrypoint.sh, ability to set APP_PARAMS="&" to run the app as
# background process inside of the container
ENV APP_PARAMS=""
# ------------------------------------------------------

# ------------------------------------------------------
## DEPRECATED
# -----------
## These options will be removed in next major release
# -----------
### Use LICENSE_KEY instead (with S not C)
ENV LICENCE_KEY=""
# ------------------------------------------------------

###############################################################
# END // ENVIRONMENT VARIABLES
###############################################################


###############################################################
# APPLICATION SETUP
###############################################################

# Enable temporary data
VOLUME /tmp

# Log files storage
RUN mkdir -p /opt/microblink-api-ws/logs

# Custom non-root user is created to enable the container run with `--user=microblink` or
# to create a custom docker image with based on this image with the option `USER microblink`
RUN adduser -D microblink

# Internal script which will expand Docker Swarm secrets in the app's entrypoint
COPY docker/docker-secrets-to-env-var-expand.sh /docker-secrets-to-env-var-expand.sh

# Precompiled C++ OCR engine with ML models and other resources
ADD microblink-core-protobuf-wrapper/wrapper/binary/linux/x64/wrapper wrapper/wrapper
ADD microblink-core-protobuf-wrapper/wrapper/resources wrapper/resources

# Packaged Java Spring Boot web application which handles HTTP requests and starts OCR engine as child processes
ADD target/api.jar app.jar

# Start Java application
COPY docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT "/entrypoint.sh"
