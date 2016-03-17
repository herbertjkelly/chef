stack = search("aws_opsworks_stack").first
Chef::Log.info("********** The stack's name is '#{stack['name']}' **********")




bash 'tagebs' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  instanceid=$(curl http://169.254.169.254/latest/meta-data/instance-id)
  region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed "s/[a-zA-Z]$//")
  volumeid=$(aws ec2 describe-instances --instance-ids $instanceid --region $region --query 'Reservations[0].Instances[0].BlockDeviceMappings[0].{VolID:Ebs.VolumeId}' --output text)
  aws ec2 create-tags --resources $volumeid --tags Key=StackName,Value="Stackname - #{stack['name']}" --region $region
  aws ec2 create-tags --resources $volumeid --tags Key=Name,Value="frs-trx-dev.research.i" --region $region
  aws ec2 create-tags --resources $volumeid --tags Key=Service,Value="frs-research-webservice" --region $region
  volumeid2=$(aws ec2 describe-instances --instance-ids $instanceid --region $region --query 'Reservations[0].Instances[0].BlockDeviceMappings[1].{VolID:Ebs.VolumeId}' --output text)
  aws ec2 create-tags --resources $volumeid2 --tags Key=StackName,Value="Stackname - #{stack['name']}" --region $region
  aws ec2 create-tags --resources $volumeid2 --tags Key=Name,Value="frs-trx-dev.research.i" --region $region
  aws ec2 create-tags --resources $volumeid2 --tags Key=Service,Value="frs-research-webservice" --region $region
  EOH
end
