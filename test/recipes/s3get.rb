require 'aws-sdk'

s3 = AWS::S3.new

# Set bucket and object name
obj = s3.buckets['herberk1'].objects['test.zip']
#
# # Read content to variable
file_content = obj.read
#
# # Log output (optional)
Chef::Log.info(file_content)
#
# # Write content to file
 file '/tmp/myobject.txt' do
   owner 'root'
     group 'root'
       mode '0755'
         content file_content
           action :create
           end
#




#include_recipe 'aws'
#
#directory "/opt/local" do
#  owner 'root'
#  group 'root'
#  mode '0755'
#  recursive true
#  action :create
#end

#s3 = AWS::S3::Client.new(region:'us-east-1')
#s3.get_object({bucket: "herberk1", key:"test.zip"},target:"/opt/local/test.zip")
