chef_gem "aws-sdk" do
  compile_time true if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
  action :install
end
gem 'aws-sdk'
require 'aws-sdk'
instance = node['ec2']['instance_id']
toTag = Array.new
toTag.push(instance)
ec2 = AWS::EC2::Client.new( :region => "eu-west-1")
instance_attributes = ec2.describe_instance_attribute({
  instance_id: instance,
  attribute: "blockDeviceMapping"
})
instance_attributes.block_device_mappings.each do|mapping|
  toTag.push(mapping.ebs.volume_id)
end
tag_instance = ec2.create_tags({
  resources: toTag,
  tags: node['aws-tag']['tags']
})



