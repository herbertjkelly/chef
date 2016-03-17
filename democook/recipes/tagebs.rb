stack = search("aws_opsworks_stack").first
Chef::Log.info("********** The stack's name is '#{stack['name']}' **********")
Chef::Log.info("********** Starting Bash to tag EBS volumes **********")
bash 'tagebs' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  #!/bin/bash
  instanceid=$(curl http://169.254.169.254/latest/meta-data/instance-id)
  region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed "s/[a-zA-Z]$//")
  for i in {0..100}
    do
        volumeid=$(aws ec2 describe-instances --instance-ids $instanceid --region $region --query 'Reservations[0].Instances[0].BlockDeviceMappings['$i'].{VolID:Ebs.VolumeId}' --output text)
        if ! [ $volumeid = "None" ]; then
                aws ec2 create-tags --resources $volumeid --tags Key=StackName,Value="Stackname - #{stack['name']}" --region $region
                aws ec2 create-tags --resources $volumeid --tags Key=Name,Value="frs-trx-dev.research.i" --region $region
                aws ec2 create-tags --resources $volumeid --tags Key=Service,Value="frs-research-webservice" --region $region
        else
                break
        fi
done
  EOH
end
Chef::Log.info("********** Finished Bash to tag EBS volumes **********")
