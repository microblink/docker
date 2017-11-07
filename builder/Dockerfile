FROM microblink/base:1.0
LABEL maintainer="Matija Stepanic <matija.stepanic@microblink.com>" version="1.0"

RUN apt-get update && \
	apt-get install -y ccache cmake ninja-build && \
	rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/* /var/tmp/*	

WORKDIR /data/build

CMD cmake -G Ninja /data/source && ninja