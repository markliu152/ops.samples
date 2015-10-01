#
# Cookbook Name:: prepare-zabbix-db
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


file_cache_path = "/etc/mysql"
db_name = "zabbix"

template "#{file_cache_path}/create_zabbix_db.sql" do
  owner "root"
  group "root"
  mode 0644
  source "create_zabbix_db.sql.erb"
  notifies :run, "execute[create_db]", :immediately
end

execute "create_db" do
  command <<-EOH
    /usr/bin/mysql -u root < #{file_cache_path}/create_zabbix_db.sql
  EOH
  not_if "mysql -u root zabbix -e 'show tables;'"
end

