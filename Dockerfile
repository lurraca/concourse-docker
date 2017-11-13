FROM ruby:2.4.2
MAINTAINER pivotal

# Install PostgreSQL
RUN apt-get update && apt-get install -y postgresql

# Install Node v 6, bower and gulp
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get update && apt-get install -y nodejs
RUN npm install -g bower
RUN npm install -g gulp

# Start and initialize PostgreSQL DB
USER postgres 
RUN /etc/init.d/postgresql start && createuser --superuser root
USER root


