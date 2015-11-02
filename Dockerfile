FROM centos:5

RUN yum update -y

RUN yum install -y \
    cvs curl gcc make autoconf automake libtool re2c flex bison

# Install Apache 1.3, with direction from
# http://www.cambus.net/compiling-apache-1.3.x-on-modern-linux-distributions/
RUN cd /usr/local/src && \
    curl -sfLO http://archive.apache.org/dist/httpd/apache_1.3.42.tar.gz && \
    tar -xzf apache_1.3.42.tar.gz && \
    cd apache_1.3.42 && \
    ./configure --enable-module=so && \
    make && \
    make install && \
    rm /usr/local/src/apache_1.3.42.tar.gz && \
    rm -rf /usr/local/src/apache_1.3.42

ADD httpd.conf /usr/local/apache/conf/httpd.conf

# Install PHP 4.4.9
RUN cd /usr/local/src && \
    curl -sfLO http://museum.php.net/php4/php-4.4.9.tar.gz && \
    tar -xzf php-4.4.9.tar.gz && \
    cd php-4.4.9 && \
    ./configure --with-mysql --with-apxs=/usr/local/apache/bin/apxs && \
    make && \
    make install && \
    rm /usr/local/src/php-4.4.9.tar.gz && \
    rm -rf /usr/local/src/php-4.4.9

RUN yum install -y mysql-server

ADD mysql/my.conf /etc/my.conf

# Install b2
RUN cd /usr/local/apache/htdocs && \
    echo -ne "\n" | cvs -d:pserver:anonymous@cafelog.cvs.sourceforge.net:/cvsroot/cafelog login && \
    cvs -z3 -d:pserver:anonymous@cafelog.cvs.sourceforge.net:/cvsroot/cafelog co -P zerodotx

ADD b2config.php /usr/local/apache/htdocs/zerodotx/b2config.php

ADD start-b2.sh /usr/local/bin/start-b2

CMD ["start-b2"]