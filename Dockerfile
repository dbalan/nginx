FROM alpine:3.2

MAINTAINER dbalan
LABEL disto=alpine program=nginx version=vcs-head

# set up build directive
RUN ["apk", "update"]
RUN ["apk", "add", "alpine-sdk"]
# dependencies to build nginx
RUN ["apk", "add", "pcre-dev", "openssl-dev", "zlib-dev", "linux-headers"]

ADD . nginx
WORKDIR nginx

RUN ["./auto/configure"]
RUN ["make"]

EXPOSE 80
# logs and config are expected here.
VOLUME ["/usr/local/nginx/logs", "/usr/local/nginx/conf"]
ENTRYPOINT ["/nginx/objs/nginx"]
