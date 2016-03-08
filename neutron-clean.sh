router_ids=$(neutron router-list | grep -i "True" | awk '{print $2}')

for router_id in $router_ids
do
    echo $router_id
    neutron router-gateway-clear $router_id
    subnet_ids=$(neutron router-port-list $router_id |
                 grep "subnet_id" | awk '{print $8}' |
                 awk -F '\"' '{print $2}')
    for subnet_id in $subnet_ids
    do
        neutron router-interface-delete $router_id $subnet_id
        neutron subnet-delete $subnet_id
    done
    neutron router-delete $router_id
done

# net_id=`neutron net-list | grep ext-net | awk '{print $2}'`
net_ids=$(neutron net-list | egrep -v '\-\-|id' | awk '{print $2}')
for net_id in $net_ids
do
    neutron net-delete $net_id
done
