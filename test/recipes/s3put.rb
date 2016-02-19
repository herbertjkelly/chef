#require 'aws-sdk'

directory "/opt/local" do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

s3 = Aws::S3::Client.new(region:'us-east-1')
s3.get_object({bucket: "herberk1", key:"test.zip"},target"/opt/local/test.zip")
