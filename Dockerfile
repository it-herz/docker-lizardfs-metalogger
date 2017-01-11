FROM      debian:latest
MAINTAINER Dmitrii Zolotov <dzolotov@herzen.spb.ru>

RUN apt-get -y update && apt-get -y install wget && \
    wget http://packages.lizardfs.com/lizardfs.key && apt-key add lizardfs.key && \
    echo "deb http://packages.lizardfs.com/debian/jessie jessie main" > /etc/apt/sources.list.d/lizardfs.list && \
    echo "deb-src http://packages.lizardfs.com/debian/jessie jessie main" >> /etc/apt/sources.list.d/lizardfs.list && \
    apt-get -y update && apt-get -y install lizardfs-metalogger && \
    mkdir /root/mfs && cp /var/lib/mfs/metadata.mfs.empty /root/mfs && \
    cp /etc/mfs/mfsexports.cfg.dist /root/mfs && \
    cp /etc/mfs/mfsmetalogger.cfg.dist /etc/mfs/mfsmetalogger.cfg && \
    sed -i 's/LIZARDFSMETALOGGER_ENABLE=false/LIZARDFSMETALOGGER_ENABLE=true/g'  /etc/default/lizardfs-metalogger

EXPOSE 9419 9420 9421 9425

VOLUME /var/lib/mfs

ENV ALLOWRW ''
ENV ALLOWRO ''
ENV PERMISSIONS ''

ADD run.sh /

RUN chmod +x /run.sh

CMD [ "/run.sh" ]
