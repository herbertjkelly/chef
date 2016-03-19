require 'net/http'
uri = URI('http://169.254.169.254/latest/meta-data/instance-id')
instanceid = Net::HTTP.get(uri)
Chef::Log.info("********** #{instanceid} **********")
