#
# Cookbook Name:: zabbix-frontend-php
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{
  nginx
  language-pack-ja
  fonts-vlgothic
  php5-fpm
  php5-mysql
  zabbix-frontend-php
}.each do |pkg_name|
  package "#{pkg_name}" do
    action :install
  end
end

template "/etc/php5/fpm/php.ini" do
  owner "root"
  group "root"
  mode 0644
  source "etc_php5_fpm_php.ini.erb"
  notifies :restart, 'service[php5-fpm]'
end

template "/etc/zabbix/zabbix.conf.php" do
  owner "www-data"
  group "www-data"
  mode 0644
  source "zabbix.conf.php.example.erb"
end

template "/etc/nginx/sites-available/default" do
  owner "root"
  group "root"
  mode 0644
  source "etc_nginx_sites-available_default.erb"
  notifies :restart, 'service[nginx]'
end

service "php5-fpm" do
  action [ :disable, :start ]
end

service "nginx" do
  action [ :disable, :start ]
end





