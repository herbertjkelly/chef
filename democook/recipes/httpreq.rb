http_request 'instanceid' do
  url 'http://169.254.169.254/latest/meta-data/instance-id'
end

Chef::Log.info("********** #{instanceid} **********")
