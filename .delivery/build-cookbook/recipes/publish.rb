#
# Cookbook Name:: build-cookbook
# Recipe:: publish
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

powershell_script "clean-workspace" do
#    command "& \"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Common7\\IDE\\devenv.exe\" /Clean"
    code <<-EOH
        & "C:/Program Files (x86)/Microsoft Visual Studio 14.0/Common7/IDE/devenv.exe" /Clean
    EOH
    cwd 'C:/dot-net/ScriptServices/src'
end

execute "restore-nuget-packages" do
    command "#{Chef::Config[:file_cache_path]}\\nuget.exe restore"
    cwd 'C:/dot-net/ScriptServices/src'
end

powershell_script "build-solution" do
#    command "& \"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Common7\\IDE\\devenv.exe\" ScriptServices.sln /Build debug /Out log.txt"
    code <<-EOH
        & "C:/Program Files (x86)/Microsoft Visual Studio 14.0/Common7/IDE/devenv.exe" ScriptServices.sln /Build debug /Out log.txt
    EOH
    cwd 'C:/dot-net/ScriptServices/src'
end

powershell_script "show-build-log" do
    command "gc log.txt -raw"
    cwd 'C:/dot-net/ScriptServices/src'
    live_stream true
end