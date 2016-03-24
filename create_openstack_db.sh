#!/bin/bash
# create openstack db

for db in keystone glance nova neutron cinder swift heat
do
    local user=$db
    local pass=111111
    mysql -e "CREATE DATABASE $db;"
    mysql -e "GRANT ALL PRIVILEGES on ${db}.* TO '${user}'@'localhost' IDENTIFIED BY '$pass';"
    mysql -e "GRANT ALL PRIVILEGES on ${db}.* TO '${user}'@'%' IDENTIFIED BY '$pass';"
done
