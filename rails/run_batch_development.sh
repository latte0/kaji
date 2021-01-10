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


cd /app
echo "cd app"
source /etc/profile.d/rbenv.sh; bundle exec rails db:create RAILS_ENV=development # 既にある場合は何もしないはず
source /etc/profile.d/rbenv.sh; bundle exec rails db:migrate RAILS_ENV=development

source /etc/profile.d/rbenv.sh; bundle exec whenever --update-crontab  --set environment=development RAILS_ENV=development
crond

while :; do sleep 10; done