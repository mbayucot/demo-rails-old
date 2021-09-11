FROM ruby:3.0.2-slim
RUN apt-get update && apt-get install -y --fix-missing \
  build-essential \
  curl \
  gcc \
  git \
  libcurl4-openssl-dev \
  libpq-dev \
  libxml2-dev \
  ssh \
  supervisor \
  vim \
  bash-completion\
  wget \
  lsb-release

ENV INSTALL_PATH /api
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile $INSTALL_PATH/Gemfile
#COPY Gemfile.lock $INSTALL_PATH/Gemfile.lock
RUN bundle install
COPY . $INSTALL_PATH

EXPOSE 3000

# Start the main process.
COPY conf/supervisor/conf.d/ /etc/supervisor/conf.d
CMD /usr/bin/supervisord -n