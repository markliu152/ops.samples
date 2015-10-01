#
# Cookbook Name:: zabbix-server
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "zabbix-server-mysql" do
  action :install
end

template "zabbix_server.conf" do
  path "/etc/zabbix/zabbix_server.conf"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[zabbix-server]'
end

template "zabbix-server" do
  path "/etc/default/zabbix-server"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[zabbix-server]'
end

execute "execute-sqls" do
  command <<-EOH
    zcat /usr/share/zabbix-server-mysql/schema.sql.gz | mysql -uzabbix zabbix
    zcat /usr/share/zabbix-server-mysql/images.sql.gz | mysql -uzabbix zabbix
    zcat /usr/share/zabbix-server-mysql/data.sql.gz   | mysql -uzabbix zabbix
  EOH
  not_if "mysql -u root zabbix -e 'select actionid, name from actions limit 3;'"
end

service "zabbix-server" do
  action [ :disable, :start ]
end

