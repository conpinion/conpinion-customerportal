FROM debian:8.2

RUN apt-get update -qq
RUN apt-get install -y build-essential
RUN apt-get install -y mysql-client
RUN apt-get install -y libmysqlclient-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libxslt1-dev
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y sudo
RUN curl --silent --location https://deb.nodesource.com/setup_5.x | bash
RUN apt-get install -y nodejs
RUN apt-get install -y imagemagick

ADD conpinion-customerportal.key /etc/ssl/conpinion-customerportal.key
ADD conpinion-customerportal.cer /etc/ssl/conpinion-customerportal.cer

RUN groupadd --gid 1000 rails
RUN useradd --create-home --shell /bin/bash --uid 1000 --gid 1000 rails

RUN mkdir /app
RUN chown rails:rails /app

RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN bash -l -c "rvm install requirements"

USER rails

RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN bash -l -c "rvm install ruby-2.3.1"
RUN echo "gem: --no-rdoc --no-ri" > /home/rails/.gemrc

WORKDIR /app

EXPOSE 3000

ADD start_rails.sh /usr/bin/
CMD ["start_rails.sh"]
