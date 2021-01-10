
FROM python:3.7
# ER図出力のために色々ダウンロード

RUN apt-get dist-upgrade \
  && apt-get update \
  && apt-get install build-essential

RUN apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    cython

#RUN mkdir -p /usr/share/fonts \
#  && cd /usr/share/fonts \
#  && wget https://ipafont.ipa.go.jp/IPAexfont/ipaexm00301.zip -O IPAfont00303.zip \
#  && unzip IPAfont00303.zip \
#  && rm IPAfont00303.zip


FROM ruby:2.7.1

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && \
    apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install nodejs

RUN yarn add node-sass
RUN apt-get -y install mariadb-client 
RUN apt-get -y install vim



ENV APP_ROOT /app 
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

ADD rails/Gemfile $APP_ROOT/Gemfile 
ADD rails/Gemfile.lock $APP_ROOT/Gemfile.lock 

RUN gem install bundler 
RUN bundle install
ADD rails/ $APP_ROOT


# ER図出力のために色々インストール
RUN apt-get install -y graphviz fontconfig
RUN fc-cache -fv
