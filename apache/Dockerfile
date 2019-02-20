FROM ubuntu:18.10
MAINTAINER Clemens Borys <cle@bor.dk>

ENV DEBIAN_FRONTEND=noninteractive

# Install all the things
RUN apt-get -qq update \
    && apt-get -qq upgrade
RUN apt-get -qq install apt-utils
RUN apt-get -qq --no-install-recommends install \
    curl zip logrotate \
    apache2 apache2-utils ssl-cert \
    libapache2-mod-php php7.2 php7.2-cli php7.2-common php7.2-curl php7.2-dev php7.2-mbstring \
	php7.2-zip php7.2-mysql php7.2-xmlrpc php7.2-xml \
    php-redis php-imagick php-igbinary php-msgpack \
    ffmpeg \
    wkhtmltopdf

# Make directories
RUN mkdir -p /srv/sites/apache/logs
RUN mkdir -p /srv/sites/parentnode
RUN mkdir -p /srv/sites/kbhff/kbhff_dk

# Clone parentnode
COPY git/ubuntu_environment/ /srv/tools

# The configuration recently changed to expect janitor to be in this location; check this is "the way it's done" now
COPY git/janitor /srv/sites/parentnode/janitor

#Clone KBHFF: (this is now linked from outside the container as a volume)
COPY git/kbhff_dk /srv/sites/kbhff/kbhff_dk
RUN chown -R www-data:staff /srv/sites/kbhff/kbhff_dk

ENV install_email cle@bor.dk

# Apache2 configuration
## Setup our default.conf (points to /srv/sites)
# The following line can be safely deleted, Josh thinks:
# RUN cat /srv/tools/conf-client/default.conf > /etc/apache2/sites-available/default.conf
# Josh: couldn't get the provided default.conf to work, here's (I think) a cleaner version
COPY apache/default.conf /etc/apache2/sites-available/default.conf
RUN a2ensite default && a2dissite 000-default &&\
	a2enmod ssl && a2enmod rewrite && a2enmod headers

## This should be replaced by a sed line that amends default.conf, not apache2.conf. This will probably entail patching default.conf / submitting a pull request to janitor
RUN echo "ServerName ${HOSTNAME}" >> /etc/apache2/apache2.conf
RUN sed -i "s/webmaster@localhost/${install_email}/;" /etc/apache2/sites-available/default.conf
RUN cp /srv/tools/conf-client/php-apache2.ini /etc/php/7.2/apache2/php.ini
RUN cp /srv/tools/conf-client/php-cli.ini /etc/php/7.2/cli/php.ini

## Create virtual host

## <This can be safely deleted Josh thinks:
# ENV apache_file_path=/srv/sites/apache/kbhff.conf
# RUN cp /srv/tools/conf-client/apache.conf "${apache_file_path}"
# RUN echo "Include \"/srv/sites/kbhff/kbhff_dk/apache/httpd-vhosts.conf\"" >> "${apache_file_path}"
# RUN cp "${apache_file_path}" /etc/apache2/sites-available
# RUN a2ensite kbhff
## />

# Josh: all the configuration of the KBHFF site actually takes place in this file, so I copy this one instead of the above
COPY git/kbhff_dk/apache/httpd-vhosts.conf /etc/apache2/sites-available/kbhff.conf
RUN a2ensite kbhff

RUN echo "127.0.0.1 kbhff.local" >> /etc/hosts

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
