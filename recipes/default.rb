#
# Cookbook Name:: surfspots
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'selinux::permissive'
include_recipe 'surfspots::spot'
include_recipe 'surfspots::webserver'
include_recipe 'surfspots::firewall'
include_recipe 'surfspots::database'