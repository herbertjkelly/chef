require 'net/http'
instanceid = Net::HTTP.get(http://169.254.169.254/latest/meta-data/instance-id)
Chef::Log.info("********** #{instanceid} **********")
