search("aws_opsworks_rds_db_instance").each do |rds_db_instance|
  Chef::Log.info("********** The RDS instance's address is '#{rds_db_instance['address']}' **********")
  Chef::Log.info("********** The RDS instance's database engine type is '#{rds_db_instance['engine']}' **********")
end
