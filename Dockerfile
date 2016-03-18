FROM sameersbn/ubuntu:14.04.20160218
MAINTAINER sameer@damagehead.com

ENV MONGO_USER=mongodb \
    MONGO_DATA_DIR=/var/lib/mongodb \
    MONGO_LOG_DIR=/var/log/mongodb

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
	&& echo 'deb http://repo.mongodb.org/apt/ubuntu/ trusty/mongodb-org/3.2 multiverse' > /etc/apt/sources.list.d/mongodb.list \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org-server mongodb-org-shell \
	&& sed '/^[[:space:]]*bindIp/d' -i /etc/mongod.conf \
	&& apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 27017/tcp
VOLUME ["${MONGO_DATA_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/bin/mongod"]
