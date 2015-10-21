#
# Cookbook Name:: surfspots
# Recipe:: database
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

mysql2_chef_gem 'default' do
  action :install
end

mysql_client 'default' do
  action :create
end

password_secret = Chef::EncryptedDataBagItem.load_secret(node['surfspots']['passwords']['secret_path'])
root_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'sql_server_root_password', password_secret)


mysql_service 'default' do
  initial_root_password root_password_data_bag_item['password']
  action [:create, :start]
end

mysql_database node['surfspots']['database']['dbname'] do
  connection(
    :host => node['surfspots']['database']['host'],
    :username => node['surfspots']['database']['username'],
    :password => root_password_data_bag_item['password']
  )
  action :create
end

user_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'db_admin_password', password_secret)

mysql_database_user node['surfspots']['database']['app']['username'] do
  connection(
    :host => node['surfspots']['database']['host'],
    :username => node['surfspots']['database']['username'],
    :password => root_password_data_bag_item['password']
  )
  password user_password_data_bag_item['password']
  database_name node['surfspots']['database']['dbname']
  host node['surfspots']['database']['host']
  action [:create, :grant]
end

cookbook_file node['surfspots']['database']['seed_file'] do
  source 'create-tables.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

execute 'initialize database' do
  command "mysql -h #{node['surfspots']['database']['host']} -u #{node['surfspots']['database']['app']['username']} -p#{user_password_data_bag_item['password']} -D #{node['surfspots']['database']['dbname']} < #{node['surfspots']['database']['seed_file']}"
  not_if  "mysql -h #{node['surfspots']['database']['host']} -u #{node['surfspots']['database']['app']['username']} -p#{user_password_data_bag_item['password']} -D #{node['surfspots']['database']['dbname']} -e 'describe spots;'"
end