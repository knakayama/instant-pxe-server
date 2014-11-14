# install base apps
%w{
  gcc
  make
}.each do |pkg|
  package pkg do
    action :install
  end
end

