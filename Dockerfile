FROM alpine:3.8

MAINTAINER Taichi Uchihara <hoge.uchihara@gmail.com>

ARG LDC_VERSION=1.12.0

ENV \
    PATH="/ldc/bin:${PATH}" \
    LD_LIBRARY_PATH="/ldc/lib:/usr/lib:/lib:${LD_LIBRARY_PATH}" \
    LIBRARY_PATH="/ldc/lib:/usr/lib:/lib:${LD_LIBRARY_PATH}"

RUN \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk add --no-cache llvm5 musl-dev gcc curl libcurl curl-dev tzdata openssl=1.1.1a-r1 bash git libevent && \
    cd / && curl -fsS -L -o "/ldc.tar.xz" "https://github.com/ldc-developers/ldc/releases/download/v${LDC_VERSION}/ldc2-${LDC_VERSION}-alpine-linux-x86_64.tar.xz" && \
    tar xf /ldc.tar.xz && \
    mv "/ldc2-${LDC_VERSION}-alpine-linux-x86_64" "/ldc" && \
    rm -rf /ldc.tar.xz

COPY \
  ./ /daizu-online-judge/

EXPOSE 8080

RUN \
  cd /daizu-online-judge/ && dub test

ENTRYPOINT [ "sh" ]
