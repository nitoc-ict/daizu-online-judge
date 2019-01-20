FROM base/archlinux:2018.10.01

MAINTAINER Taichi Uchihara <hoge.uchihara@gmail.com>

ARG LDC_VERSION=1.12.0

ENV \
    PATH="/root/ldc/bin:${PATH}" \
    LD_LIBRARY_PATH="/root/ldc/lib:/usr/lib:/lib:${LD_LIBRARY_PATH}" \
    LIBRARY_PATH="/root/ldc/lib:/usr/lib:/lib:${LD_LIBRARY_PATH}"

RUN \
  pacman -Syy --noconfirm && pacman -Syu --noconfirm && pacman -S --noconfirm ldc dub openssl libevent
#  wget https://www.archlinux.org/packages/community/x86_64/ldc/download/ && \
#  pacman -U  --noconfirm ldc-2_1.12.0-1-x86_64.pkg.tar.xz
#  tar xfv ldc2-1.12.0-linux-aarch64.tar.xz
#  wget https://github.com/ldc-developers/ldc/releases/download/v1.12.0/ldc2-1.12.0-linux-aarch64.tar.xz && \

COPY \
  ./ /daizu-online-judge/

RUN \
  cd /daizu-online-judge/ && dub test

ENTRYPOINT [ "sh" ]
