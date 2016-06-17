#
# Cookbook Name:: erlang
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
file_name = "erlang-#{default['erlang']['version']}"
case node['platform_family']
when 'rhel'
  remote_file "#{Chef::Config['file_cache_path']}/#{file_name}.rpm" do
    source "#{node['erlang']['url']}"
    action :create
    not_if {File.exist?("#{Chef::Config['file_cache_path']}/#{file_name}.rpm")}
  end

  package 'erlang-erts' do
    action :purge
    not_if "erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell | grep 17"
  end

  # wx関係のパッケージが必要だからインストール
  node['erlang']['dev-packages'].each do |pkg|
    package "#{pkg}" do
      action :install
      not_if "rpm -qa | grep #{pkg}"
    end
  end

  bash "install_erlang" do
    cwd Chef::Config['file_cache_path']
    code <<-EOH
    rpm -Uvh #{file_name}.rpm
    EOH
    not_if "erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell | grep 17"
  end
end
