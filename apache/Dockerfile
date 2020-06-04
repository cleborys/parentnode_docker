FROM ubuntu:latest
MAINTAINER Joshua Hunt <joshua.edward.hunt@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

# Install all the things
RUN apt update -y \
    && apt upgrade -y \
	&& apt install -y \
    	curl \
		logrotate \
		zip \
		apache2 \
		apache2-utils \
		ssl-cert \
		libapache2-mod-php \
		php7.2 \
		php7.2-cli \
		php7.2-common \
		php7.2-curl \
		php7.2-dev php7.2-mbstring \
		php7.2-zip \
		php7.2-mysql \
		php7.2-xmlrpc \
		php7.2-xml \
		php-redis \
		php-imagick \
		php-igbinary \
		php-msgpack \
		ffmpeg \
		wkhtmltopdf

# Make directories
RUN mkdir -p /srv/sites/apache/logs /srv/sites/parentnode /srv/sites/kbhff/kbhff_dk

# Clone parentnode
COPY git/ubuntu_environment/ /srv/tools

ENV install_email joshua.edward.hunt@gmail.com

# Apache2 configuration
## Setup our default.conf (points to /srv/sites)
COPY apache/default.conf /etc/apache2/sites-available/default.conf
RUN a2ensite default && a2dissite 000-default &&\
	a2enmod ssl && a2enmod rewrite && a2enmod headers \
	&& echo "ServerName ${HOSTNAME}" >> /etc/apache2/apache2.conf \
	&& sed -i "s/webmaster@localhost/${install_email}/;" /etc/apache2/sites-available/default.conf \
	&& cp /srv/tools/conf-client/php-apache2.ini /etc/php/7.2/apache2/php.ini \
	&& cp /srv/tools/conf-client/php-cli.ini /etc/php/7.2/cli/php.ini

## Create virtual host

COPY git/kbhff_dk/apache/httpd-vhosts.conf /etc/apache2/sites-available/kbhff.conf
RUN a2ensite kbhff
RUN echo "127.0.0.1 kbhff.local" >> /etc/hosts

#Clone KBHFF:
COPY git/kbhff_dk /srv/sites/kbhff/kbhff_dk
RUN chown -R www-data:staff /srv/sites/kbhff/kbhff_dk
RUN mkdir -p /srv/sites/kbhff/kbhff_dk/theme/config
#This should not be done the first time you set it up...
COPY apache/connect_db.php /srv/sites/kbhff/kbhff_dk/theme/config/connect_db.php 

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
