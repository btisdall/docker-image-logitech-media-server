FROM ubuntu:14.04
MAINTAINER Lars Kellogg-Stedman <lars@oddbit.com>

ENV SQUEEZE_VOL /srv/squeezebox
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV PACKAGE_VERSION_URL=http://downloads.slimdevices.com/nightly/8.0/lms/0d170acd9c427444df84a414e22d3ab35862eff3/logitechmediaserver_8.0.0~1592463207_amd64.deb

RUN apt-get update && \
	apt-get -y install \
    curl \
    wget \
    faad \
    flac \
    lame \
    sox \
    libio-socket-ssl-perl \
    liblinux-inotify2-perl \
  && \
	curl -Lsf -o /tmp/logitechmediaserver.deb ${PACKAGE_VERSION_URL} && \
	dpkg -i /tmp/logitechmediaserver.deb && \
	rm -f /tmp/logitechmediaserver.deb && \
	apt-get clean

VOLUME $SQUEEZE_VOL
EXPOSE 3483 3483/udp 9000 9090

COPY entrypoint.sh /entrypoint.sh
COPY start-squeezebox.sh /start-squeezebox.sh
RUN chmod 755 /entrypoint.sh /start-squeezebox.sh
ENTRYPOINT ["/entrypoint.sh"]
