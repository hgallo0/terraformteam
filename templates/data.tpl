#!/bin/bash

yum install git -y
wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
unzip terraform_0.12.21_linux_amd64.zip
mv terraform /usr/local/bin/

function exit_code {
	if [ $? -ne 0 ] ; then
         echo "script error" > /tmp/userdata.log
	       exit 1
	fi
}

LIST=$(aws s3 ls s3://cs641-config-files/TerraformTeam/ | awk '{print $NF}' | grep -v 0 | cut -d . -f1)
exit_code
for i in $LIST
do
  useradd $${i}
  exit_code
  mkdir /home/$${i}/.ssh
  exit_code
  aws s3 cp s3://cs641-config-files/TerraformTeam/$${i}.pub /home/$${i}/.ssh/authorized_keys
  exit_code
  chown -R $${i}:$${i} /home/$${i}/.ssh
  exit_code
  chmod 0644 /home/$${i}/.ssh/authorized_keys
  exit_code
  echo "$${i} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users
done
exit 0
