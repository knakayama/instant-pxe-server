# install package
package "tftpd-hpa" do
  action :install
end

template "/etc/default/tftpd-hpa" do
  source "tftpd-hpa.erb"
  owner  "root"
  group  "root"
  mode   00644
end

service "tftpd-hpa" do
  action [:enable, :start]
  supports :status => true, :restart => true
  subscribes :restart, "template[/etc/default/tftpd-hpa]"
end

directory "/home/#{node['local']['user']}/tftp" do
  owner node['local']['user']
  group node['local']['group']
  mode 00755
  action :create
end

