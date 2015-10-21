#
# Cookbook Name:: surfspots
# Recipe:: spot
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

group node['surfspots']['group']

user node['surfspots']['user'] do
  group node['surfspots']['group']
  system true
  shell '/bin/bash'
end