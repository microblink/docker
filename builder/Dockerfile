FROM microblink/base:1.0
LABEL maintainer="Matija Stepanic <matija.stepanic@microblink.com>"

RUN apt-get update

RUN apt-get install -y ninja-build
RUN apt-get install -y cmake
RUN apt-get install -y ccache

VOLUME ["/data/source", "/data/build"]

ENTRYPOINT ["sh", "-c", "cd /data/build && cmake -G Ninja /data/source && ninja"]