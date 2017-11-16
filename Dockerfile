FROM ubuntu:16.04
MAINTAINER pivotal

SHELL ["/bin/bash", "-c"]

# Install dependencies
RUN apt-get update && apt-get install -y autoconf bison build-essential curl git libfontconfig libpq-dev libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev wget

# Install Rbenv and Ruby

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
ENV PATH $PATH:/root/.rbenv/bin:/root/.rbenv/shims
RUN rbenv install 2.4.0 && rbenv global 2.4.0 && rbenv rehash
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN gem install bundler

## Install Node
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get update && apt-get install -y nodejs
RUN npm install -g bower
RUN npm install -g gulp

# Install PostgreSQL
RUN apt-get update && apt-get install -y postgresql

# Start and initialize PostgreSQL DB
USER postgres 
RUN /etc/init.d/postgresql start && createuser --superuser root
USER root

ADD run-things /usr/bin/run-things
RUN chmod a+x /usr/bin/run-things

#ENTRYPOINT ["/usr/bin/run-things && /bin/bash"]
