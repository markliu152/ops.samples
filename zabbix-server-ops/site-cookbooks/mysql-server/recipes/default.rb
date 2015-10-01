#
# Cookbook Name:: mysql-server
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "mysql-server-5.6" do
  action :install
end

template "my.cnf" do
  path "/etc/mysql/my.cnf"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[mysql]'
end

service "mysql" do
  action [ :disable, :start ]
end


