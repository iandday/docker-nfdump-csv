FROM netsage/nfdump-collector:1.6.23
LABEL org.opencontainers.image.source="https://github.com/netsage-project/docker-nfdump-collector/" 
USER root

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install -y python3 crontabs

# comment out PAM
RUN sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/crond

VOLUME /data
VOLUME /log

COPY crontab /etc/cron.d/crontab
COPY netflow_dump.py /netflow_dump.py
RUN chmod 0644 /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab

# run crond as main process of container
CMD ["crond", "-n"]


