app = search("aws_opsworks_app").first
Chef::Log.info("********** The app's short name is '#{app['shortname']}' **********")
Chef::Log.info("********** The app's URL is '#{app['app_source']['url']}' **********")

bash 'tagebs' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  instanceid=$(curl http://169.254.169.254/latest/meta-data/instance-id)
  region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed "s/[a-zA-Z]$//")
  volumeid=$(aws ec2 describe-instances --instance-ids $instanceid --region $region --query 'Reservations[0].Instances[0].BlockDeviceMappings[0].{VolID:Ebs.VolumeId}' --output text)
  aws ec2 create-tags --resources $volumeid --tags Key=Details,Value="Root volume of $instanceid" --region $region
  EOH
end
