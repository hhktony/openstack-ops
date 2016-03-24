#!/usr/bin/env bash
#  Filename: keystone-init.sh
#   Created: 2016-03-24 09:15:19
#      Desc: TODO (some description)
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself

# create tenant
for tenant in admin demo service
do
    tenant_name=`keystone tenant-list | awk "/${tenant}/ {print $4}"`
    if [ -z "${tenan_tname}" ]; then
        keystone tenant-create --name ${tenant} --description "Openstack ${tenant} Tenant"
    else
        echo "${tenant} tenant have created"
    fi
done

# create admin role
role_name=`keystone role-list | awk -F "|" '/admin/ {print $3}'`
if [ -z "${role_name}" ]; then
    keystone role-create --name admin
else
    echo "${role_name} role have created"
fi

# create user
for user in keystone glance nova neutron cinder swift heat admin demo
do
    name=$(keystone user-list | awk "/${user}/ {print $4}")
    pass='111111'
    if [ -z "${name}" ]; then
        case "${name}" in
            admin)
                keystone user-create --name ${name} --pass ${pass} --email ${name}@example.com >/dev/null
                keystone user-role-add --user ${name} --role admin --tenant admin
                keystone user-role-add --user ${name} --role _member_ --tenant admin
                ;;
            demo)
                keystone user-create --name ${name} --pass ${pass} --email ${name}@example.com >/dev/null
                keystone user-role-add --user ${name} --role _member_ --tenant demo
                ;;
            *)
                keystone user-create --name ${user} --pass ${pass} --email ${user}@example.com >/dev/null
                keystone user-role-add --user ${user} --role admin --tenant service
                keystone user-role-add --user ${user} --role _member_ --tenant service
                ;;
        esac
    else
        echo "$user have created"
    fi
    keystone user-role-list --user $user --tenant service
done
