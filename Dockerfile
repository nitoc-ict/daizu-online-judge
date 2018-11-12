from alpine

MAINTAINER Taichi Uchihara <hoge.uchihara@gmail.com>

ENV \
  LDC_VERSION=1.12.0 \
  DUB_VERSION=1.12.0

RUN \
  apk add --no-cache bash llvm5 musl-dev gcc curl libcurl curl-dev tzdata openssl xz git && \
  cd / && curl -fsS -L -o "/ldc.tar.xz" "https://github.com/ldc-developers/ldc/releases/download/v${LDC_VERSION}/ldc2-${LDC_VERSION}-alpine-linux-x86_64.tar.xz" && \
  tar xf /ldc.tar.xz && \
  mv "/ldc2-${LDC_VERSION}-alpine-linux-x86_64" "/ldc" && \
  rm -rf /ldc.tar.xz

ENV \
  PATH="/ldc/bin:${PATH}" \
  LD_LIBRARY_PATH="/ldc/lib:/usr/lib:/lib:${LD_LIBRARY_PATH}" \
  LIBRARY_PATH="/ldc/lib:/usr/lib:/lib:${LD_LIBRARY_PATH}"

RUN \
 cd /tmp \
 && echo 'void main() {import std.stdio; stdout.writeln("pass test"); }' > test.d \
 && ldc2 test.d \
 && ./test && rm test*

COPY \
  ./ /daizu-online-judge/

#EXPOSE 8080
#ENTRYPOINT [ "sh" ]
