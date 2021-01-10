FROM centos:7

# rubyとrailsのバージョンを指定
ENV ruby_ver="2.7.1"
ENV rails_ver="5.2.2"

# 必要なパッケージをインストール
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install git make autoconf curl wget
RUN yum -y install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel sqlite-devel bzip2
RUN yum clean all

# rubyとbundleをダウンロード
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

# コマンドでrbenvが使えるように設定
RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init --no-rehash -)"' >> /etc/profile.d/rbenv.sh

# rubyとrailsをインストール
RUN source /etc/profile.d/rbenv.sh; rbenv install ${ruby_ver}; rbenv global ${ruby_ver}
RUN source /etc/profile.d/rbenv.sh; gem update --system; gem install --no-ri --no-rdoc rails; gem install bundler

RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - && yum -y install nodejs

#RUN yum install ImageMagick ImageMagick-devel ImageMagick-perl
#RUN yum install -y cron


RUN curl -sL https://rpm.nodesource.com/setup_11.x | bash - && \
    curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo && \
    yum -y install epel-release

# Install packages
RUN yum -y  groupinstall "Development Tools" && \
    yum -y install \
        gcc \
        nodejs \
        yarn  \
        wget \
        mysql \
        redis \
        readline-devel \
        libffi-devel \
        libxslt-devel \
        zlib-devel \
        openssl-devel \
        mysql-devel \ 
        yum-cron \
        cronie \
        ImageMagick \
        ImageMagick-devel \
        ImageMagick-perl \
        sqlite-devel && \
    yum clean all


ENV APP_ROOT /app 
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT
RUN pwd

ADD rails/Gemfile $APP_ROOT/Gemfile 
ADD rails/Gemfile.lock $APP_ROOT/Gemfile.lock 

RUN source /etc/profile.d/rbenv.sh; gem install bundler 
RUN source /etc/profile.d/rbenv.sh; bundle install
ADD rails/ $APP_ROOT


RUN source /etc/profile.d/rbenv.sh; gem update --system
