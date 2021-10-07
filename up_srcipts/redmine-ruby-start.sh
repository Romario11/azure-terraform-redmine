#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install ruby-full ruby-railties git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev libpq-dev -y
sudo gem install bundler
sudo gem install rails
#sudo mkdir /home/${USER_NAME}/redmine_file_storage
sudo mkdir /home/${USER_NAME}/redmine
sudo curl -o /home/${USER_NAME}/redmine-4.2.2.tar.gz https://www.redmine.org/releases/redmine-4.2.2.tar.gz
sudo tar xvf /home/${USER_NAME}/redmine-4.2.2.tar.gz -C /home/${USER_NAME}/
sudo rm home/${USER_NAME}/redmine-4.2.2.tar.gz
sudo cp -a home/${USER_NAME}/redmine-4.2.2/. home/${USER_NAME}/redmine
sudo cp /home/${USER_NAME}/database.yml /home/${USER_NAME}/redmine/config/
#sudo cp /home/${USER_NAME}/configuration.yml /home/${USER_NAME}/redmine/config/
cd /home/${USER_NAME}/redmine
bundle install --without development test
bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
echo en | RAILS_ENV=production bundle exec rake redmine:load_default_data
sudo mkdir -p tmp tmp/pdf public/plugin_assets
sudo chown -R ${USER_NAME}:${USER_NAME} files log tmp public/plugin_assets
sudo chmod -R 755 files log tmp public/plugin_assets
sudo bash -c 'echo "@reboot root cd /home/ubuntu/redmine/ && sudo bundle exec rails server webrick -e production" >> /etc/crontab'
bundle exec  rails server webrick -e production