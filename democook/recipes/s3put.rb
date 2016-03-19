Chef::Log.info "****** Tag ebs #{node['opsworks']['instance']['layers']} ****"

node['aws-tag']['tags'].each do |lyr|
    Chef::Log.info "****** Tag ebs #{node['aws-tag']['tags'][lyr]} ****"
end
