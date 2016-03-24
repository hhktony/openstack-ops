NETID1=`neutron net-show int-net | awk '{if (NR == 5) {print $4}}'`
nova boot  --flavor mini --image "cirros" --nic net-id=$NETID1 vm1
