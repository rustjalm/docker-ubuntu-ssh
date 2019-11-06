FROM ubuntu:16.04
MAINTAINER Doro Wu <fcwu.tw@gmail.com>

EXPOSE 3000

ENV DEBIAN_FRONTEND=noninteractive \
    USER=ubuntu \
    PASS=ubuntu

# no Upstart or DBus
# https://github.com/dotcloud/docker/issues/1724#issuecomment-26294856
RUN apt-get update && apt-mark hold initscripts udev plymouth mountall && \
    dpkg-divert --local --rename --add /sbin/initctl && ln -fs /bin/true /sbin/initctl && \
    apt-get install -yqq --no-install-recommends \
      openssh-server \
      pwgen \
      sudo \
      vim-tiny \
      ca-certificates \
      curl

COPY ./package* /src/

WORKDIR /src

COPY ./src/* /src/

CMD ["/src/startup.sh"]
