FROM ubuntu:16.04
MAINTAINER pivotal

# Install Rbenv and Ruby
RUN apt-get update && apt-get install -y autoconf bison build-essential git libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && echo 'eval "$(rbenv init -)"' >> ~/.bashrc && /bin/bash -c 'source ~/.bashrc'
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN rbenv install 2.4.0

# Install PostgreSQL
RUN apt-get update && apt-get install -y postgresql

# Start and initialize PostgreSQL DB
USER postgres 
RUN /etc/init.d/postgresql start && createuser --superuser root
USER root

RUN systemctl enable postgresql


