#DOCKER-VERSION 0.3.4
FROM    ubuntu

RUN	echo "deb-src http://us.archive.ubuntu.com/ubuntu/ precise main" >> /etc/apt/sources.list
RUN	echo "deb-src http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN	apt-get update

RUN apt-get install -y openssl wget
RUN apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion -y

RUN	wget ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
RUN	tar -xf ruby-2.0.0-p247.tar.gz
RUN cd /ruby-2.0.0-p247; ./configure
RUN cd /ruby-2.0.0-p247; make
RUN cd /ruby-2.0.0-p247; make install

RUN rm -R ruby-2.0.0-p247.tar.gz
RUN rm -R ruby-2.0.0-p247

RUN wget http://nodejs.org/dist/v0.10.15/node-v0.10.15-linux-x64.tar.gz
RUN tar -xf node-v0.10.15-linux-x64.tar.gz
RUN ln node-v0.10.15-linux-x64/bin/node /bin/node
RUN ln node-v0.10.15-linux-x64/bin/npm /bin/npm
RUN rm node-v0.10.15-linux-x64.tar.gz

RUN gem install bundler
#ADD . /src
#RUN cd /src; bundle install

EXPOSE 9292
#RUN echo "cd /src; ./bin/rackup" > /doit
#RUN chmod +x /doit
#CMD ["/bin/bash", "-e", "/doit"]




