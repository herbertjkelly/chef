instance = search("aws_opsworks_instance").first
Chef::Log.info "****** '#{instance['ec2_instance_id']}' ******"
