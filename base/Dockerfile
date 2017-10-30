FROM sgrio/java-oracle:server_jre_8_unlimited
LABEL maintainer="Matija Stepanic <matija.stepanic@microblink.com>"
RUN apt-get update
RUN apt-get install -y gtk2.0
ADD blinkid-core/lib/Linux/x64 tools
RUN ln ./tools/LicenseRequestTool /bin/LicenseRequestTool
CMD ["bash"]