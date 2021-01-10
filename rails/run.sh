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
rails db:create RAILS_ENV=production # 既にある場合は何もしないはず
rails db:migrate RAILS_ENV=production 

# whenever --update-crontab
# cron
echo "start rails command: 'production rails s' "
RAILS_ENV=production bundle exec puma -C config/puma.rb
