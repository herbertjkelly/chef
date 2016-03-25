Chef::Log.info("********** Setting MTU to 1500 **********")
bash 'tagebs' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  #!/bin/bash
    ifconfig eth0 mtu 1500 up
  EOH
end
