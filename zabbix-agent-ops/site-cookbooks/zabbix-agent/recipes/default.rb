#
# Cookbook Name:: zabbix-agent
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "zabbix-agent" do
  action :install
end

service "zabbix-agent" do
  action [ :disable, :start ]
end

