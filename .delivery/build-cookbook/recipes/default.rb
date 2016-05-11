#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

remote_file "#{Chef::Config[:file_cache_path]}/nuget.exe" do
    source 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe'
end
