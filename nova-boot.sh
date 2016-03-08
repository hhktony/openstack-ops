#!/usr/bin/env bash
#  Filename: nova-boot.sh
#   Created: 2015-12-03 19:45:25
#      Desc: nova boot
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself
if [ $# != 1 ]; then
  echo "Usage: a.sh instance_name"
  exit 1
fi

. ~/.admin-openrc.sh
nova_boot_tmp_file="nova-boot-tmp-$(openssl rand -hex 10)"
nova image-list | egrep -v "^\+|\| ID" > $nova_boot_tmp_file
awk '{print NR") "$4}' $nova_boot_tmp_file
printf "Enter n of options (ex: 1) "
read s
image=$(sed -n "${s}p" $nova_boot_tmp_file | awk '{print $2}')
# echo $image
rm $nova_boot_tmp_file

nova flavor-list | egrep -v "^\+|\| ID" > $nova_boot_tmp_file
awk '{print NR") "$4" "$6" "$8}' $nova_boot_tmp_file
printf "Enter n of options (ex: 1) "
read s
flavor=$(sed -n "${s}p" $nova_boot_tmp_file | awk '{print $4}')
# echo $flavor
rm $nova_boot_tmp_file

nova network-list | egrep -v "^\+|\| ID" > $nova_boot_tmp_file
awk '{print NR") "$4}' $nova_boot_tmp_file
printf "Enter n of options (ex: 1) "
read s
network=$(sed -n "${s}p" $nova_boot_tmp_file | awk '{print $2}')
# echo $network
rm $nova_boot_tmp_file

nova boot --image $image --flavor $flavor --nic net-id=$network $1

echo "nova boot --image $image --flavor $flavor --nic net-id=$network $1"

# --security-group default demo-instance1
