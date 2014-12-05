FROM centos:latest
MAINTAINER wnkz

ENV PKG_NAME arachni
ENV PKG_VER 1.0.5-0.5.6-linux-x86_64
ENV PKG_FILE ${PKG_NAME}-${PKG_VER}.tar.gz
ENV PKG_URL http://downloads.arachni-scanner.com/${PKG_FILE}
ENV PKG_SHA1 4d466d118a85c24ffa51a20a4a01547d5c898591

RUN yum -y update && yum install -y wget tar 
RUN \
 wget -P / ${PKG_URL} \
 && echo "${PKG_SHA1} /${PKG_FILE}" | sha1sum -c - \
 && tar -xvzf /${PKG_FILE} -C / \
 && rm -f /${PKG_FILE} \
 && mv arachni* arachni
 
EXPOSE 9292
VOLUME ["/arachni/system/arachni-ui-web/db"]

WORKDIR /arachni
CMD ["bin/arachni_web"]
