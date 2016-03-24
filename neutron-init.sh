neutron net-create ext-net \
        --router:external True \
        --provider:network_type flat \
        --provider:physical_network external \
        --shared

neutron subnet-create ext-net \
        --name ext-subnet \
        --allocation-pool start=10.0.0.40,end=10.0.0.50 \
        --disable-dhcp --gateway 10.0.0.254 10.0.0.0/24

# neutron net-create int-net \
#         --provider:network_type vxlan \
#         --provider:segmentation_id 11 \
neutron net-create int-net --shared
# neutron net-create int-net
neutron subnet-create int-net \
        --name int-subnet \
        --gateway 172.16.0.254 172.16.0.0/24

neutron router-create router1
neutron router-interface-add router1 int-subnet
neutron router-gateway-set router1 ext-net
