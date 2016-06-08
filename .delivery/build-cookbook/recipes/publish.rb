#
# Cookbook Name:: build-cookbook
# Recipe:: publish
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

src_dir = File.expand_path("#{node['delivery']['workspace']['repo']}/src")

execute "restore-nuget-packages" do
    command "#{Chef::Config[:file_cache_path]}\\nuget.exe restore"
    cwd src_dir
end

powershell_script "build-solution" do
    code <<-EOH
        & "C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\msbuild.exe" ScriptServices.sln /fl /flp:logFile=ScriptServices.build.log
    EOH
    cwd src_dir
end
