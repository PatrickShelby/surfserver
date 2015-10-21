#
# Cookbook Name:: surfspots
# Recipe:: webserver
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

httpd_service 'spots' do
  mpm 'prefork'
  action [:create, :start]
end

httpd_config 'spots' do
  instance 'spots'
  source 'spots.conf.erb'
  notifies :restart, 'httpd_service[spots]'
end

directory node['surfspots']['document_root'] do
  recursive true
end

password_secret = Chef::EncryptedDataBagItem.load_secret(node['surfspots']['passwords']['secret_path'])
user_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'db_admin_password', password_secret)

template "#{node['surfspots']['document_root']}/index.php" do
  source 'index.php.erb'
  mode '0644'
  owner node['surfspots']['user']
  group node['surfspots']['group']
  variables({
    :database_password => user_password_data_bag_item['password']
  })
end

httpd_module 'php' do
  instance 'spots'
end

package 'php-mysql' do
  action :install
  notifies :restart, 'httpd_service[spots]'
end