# install subversion
package "subversion" do
  action :install
end

bash "compile pxe-pdhcp" do
	cwd "#{Chef::Config[:file_cache_path]}"
	code <<-EOT
		svn co http://svn.coderepos.org/share/lang/c/pxe-pdhcp
		cd pxe-pdhcp
		make
	EOT
	not_if { File.directory?("#{Chef::Config[:file_cache_path]}/pxe-pdhcp") }
end

bash "boot pxe-pdhcp" do
	cwd "#{Chef::Config[:file_cache_path]}"
	code <<-EOT
	./pxe-pdhcp/pxe-pdhcp -l 0.0.0.0 -b 255.255.255.255 -t "#{node['local']['ip']}" -d pxelinux.0 &
	EOT
	not_if "ps auxww | grep -qE '[p]xelinux'"
end

