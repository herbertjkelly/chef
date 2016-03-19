include_recipe "aws::aws"
unless node['aws-tag']['tags'].empty? || node['aws-tag']['tags'].nil?
	aws_resource_tag node['ec2']['instance_id'] do
    	tags(node['aws-tag']['tags'])
    	action :update
	end

    Chef::Log.info "****** Tagging ebs ******"
	aws_resource_tag "db_ebs_volume" do
      resource_id lazy { node['aws']['ebs_volume']['db_ebs_volume']['volume_id'] }
      tags(node['aws-tag']['tags'])
      action :update
    end
end
