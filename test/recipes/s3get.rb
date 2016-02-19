require 'aws-sdk'

directory "/opt/local" do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end
