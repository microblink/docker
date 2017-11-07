FROM sgrio/java-oracle:server_jre_8_unlimited
LABEL maintainer="Matija Stepanic <matija.stepanic@microblink.com>" version="1.0"

RUN apt-get update && \
	apt-get install -y gtk2.0 && \
	rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/* /var/tmp/*	
