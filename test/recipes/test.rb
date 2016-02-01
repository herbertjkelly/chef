instance = search("aws_opsworks_instance", "self:true").first
Chef::Log.info("********** For instance '#{instance['instance_id']}', the instance's public IP address is '#{instance['public_ip']}' **********")
Chef::Log.info("********** For instance '#{instance['instance_id']}', the autoscaling type is '#{instance['auto_scaling_type']}' **********") I
 if instance['auto_scaling_type'] == null
    Chef::Log.info("******* This is a 24/7 instance **********")
  end
