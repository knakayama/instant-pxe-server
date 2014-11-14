# download iso
remote_file "#{Chef::Config[:file_cache_path]}/#{node['iso']['name']}" do
  source node['iso']['url']
end

mount "/mnt" do
  device "#{Chef::Config[:file_cache_path]}/#{node['iso']['name']}"
  fstype "iso9660"
  options "loop"
end

bash "copy files" do
  code <<-EOT
    cp -ipvr /mnt/install/netboot/* "/home/#{node['local']['user']}/tftp"
  EOT
  not_if { File.file?("/home/#{node['local']['user']}/tftp/pxelinux.0") }
end

