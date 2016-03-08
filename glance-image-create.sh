# Liberty
glance image-create --name "cirros-0.3.4-x86_64" \
                    --file cirros-0.3.4-x86_64-disk.img \
                    --disk-format qcow2 --container-format bare \
                    --visibility public \
                    --progress

# Juno
# glance image-create --name "cirros-0.3.4-x86_64" \
#                     --file cirros-0.3.4-x86_64-disk.img \
#                     --disk-format qcow2 --container-format bare \
#                     --is-public True \
#                     --progress
