FROM centos:6.6
MAINTAINER George Liu <https://github.com/centminmod/docker-centos66-mariadb10.1>
# Setup MariaDB 10.1 on CentOS 6.6
RUN yum -y install epel-release wget nano which perl-DBI python-setuptools && rm -rf /var/cache/*; echo "" > /var/log/yum.log && easy_install pip && easy_install supervisor && easy_install supervisor-stdout
ADD supervisord.conf /etc/supervisord.conf
ADD supervisord_init /etc/rc.d/init.d/supervisord
RUN chmod +x /etc/rc.d/init.d/supervisord && mkdir -p /etc/supervisord.d/ && touch /var/log/supervisord.log && chmod 0666 /var/log/supervisord.log && rpm --import http://yum.mariadb.org/RPM-GPG-KEY-MariaDB
# ADD mariadb.repo /etc/yum.repos.d/mariadb.repo
RUN echo "exclude=*.i386 *.i586 *.i686 nginx* php* mysql*">> /etc/yum.conf && yum update -y && yum -y install libaio unixODBC Judy Judy-devel perl-Exporter-Lite perl-File-FcntlLock perl-Getopt-Long-Descriptive perl-IPC-Cmd perl-Sys-Hostname-Long && rm -rf /var/cache/* && echo "" > /var/log/yum.log && mkdir -p /var/lib/mysql && groupadd mysql && useradd -r -g mysql mysql && chown -R mysql:mysql /var/lib/mysql && mkdir -p /home/mysqltmp && rm -rf /etc/my.cnf
ADD my.cnf /etc/my.cnf
ADD mysqlsetup /root/tools/mysqlsetup
RUN chmod +x /root/tools/mysqlsetup && /root/tools/mysqlsetup
ADD mysqlstart /root/tools/mysqlstart
RUN chmod +x /root/tools/mysqlstart && ls -lah /var/lib/mysql && tail -80 /var/log/mysqld.log && yum -y install perl-DBD-MySQL && yum clean all && rm -rf /var/cache/* && echo "" > /var/log/yum.log && echo "" > /var/log/mysqld.log && echo "" > /var/log/yum.log && echo "" > /var/log/secure && echo "" > /var/log/messages

# Expose 3306 to outside
EXPOSE 3306

# Service to run
ENTRYPOINT ["/root/tools/mysqlstart"]