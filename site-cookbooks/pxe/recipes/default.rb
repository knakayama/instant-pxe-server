#
# Cookbook Name:: pxe
# Recipe:: default
#

%w{
  base
  pxe-pdhcp
}.each do |recipe|
  include_recipe "pxe::#{recipe}"
end

