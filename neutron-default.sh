neutron net-create ext-net \
        --router:external True \
        --provider:network_type flat \
        --provider:physical_network external \
        --shared

neutron subnet-create ext-net \
        --name ext-subnet \
        --allocation-pool start=10.0.0.40,end=10.0.0.50 \
        --disable-dhcp --gateway 10.0.0.254 10.0.0.0/24

# neutron net-create default \
#         --provider:network_type vxlan \
#         --provider:segmentation_id 11 \
neutron net-create default --shared
# neutron net-create default
neutron subnet-create default \
        --name default-subnet \
        --gateway 172.16.0.254 172.16.0.0/24

neutron router-create default_router
neutron router-interface-add default_router default-subnet
neutron router-gateway-set default_router ext-net
