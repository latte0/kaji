#!/bin/bash

if [ -s ./set_secret_env.sh ]; then
  # 秘密の環境変数設定ファイルがある場合は読み込む
  source ./set_secret_env.sh
fi

path=/app/tmp/pids/server.pid
if [ -e ${path} ]; then
  rm ${path}
fi

#mysqlの起動を待つ
until mysqladmin ping -h api-db --silent; do
  echo 'waiting for mysqld to be connectable...'
  sleep 2
done


RAILS_ENV=development rails db:migrate
RAILS_ENV=development rails db:seed

# whenever --update-crontab
# cronecho "start rails command: 'production rails s' "
RAILS_ENV=development bundle exec puma -C config/puma.rb

#nginxを通さない
#RAILS_ENV=development bundle exec rails s -b 0.0.0.0