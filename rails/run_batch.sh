#!/bin/bash

if [ -s ./set_secret_env.sh ]; then
  # 秘密の環境変数設定ファイルがある場合は読み込む
  source ./set_secret_env.sh
fi

# なんかエラー終了するとserver.pidが残ってて起動できないから消す
path=/app/tmp/pids/server.pid
if [ -e ${path} ]; then
  rm ${path}
fi

mkdir -p ./tmp/sockets
mkdir -p ./tmp/pids


echo "compile assets..."
# RAILS_ENV=production rails assets:precompile
# static fileをcompile
# RAILS_ENV=production rails webpacker:compile


echo "start migrate"
source /etc/profile.d/rbenv.sh; bundle exec rails db:create RAILS_ENV=production # 既にある場合は何もしないはず
source /etc/profile.d/rbenv.sh; bundle exec rails db:migrate RAILS_ENV=production 

source /etc/profile.d/rbenv.sh; bundle exec whenever --update-crontab
crond

while :; do sleep 10; done