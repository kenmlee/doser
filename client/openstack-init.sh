#!/bin/sh

# initialization script. run it when you first time start up a keystone container
KEYSTONE_HOST=keystone
GLANCE_HOST=glance
NOVA_HOST=nova

# when iniitialization, we need using 'admin_token' to access keystone service
# after that we don't need this
export OS_SERVICE_TOKEN=4d64003ad5e22204c8e4
export OS_SERVICE_ENDPOINT=http://$KEYSTONE_HOST:35357/v2.0

# Define Region. Pay attention to the name
REGION_NAME=regionOne

########### Tenant-Role-User ##############
# Tenant	User		Password	Roles
#-------------------------------------------------------------
# adminTenant	admin		adminpasswd	admin
#
# serviceTenant	keystone			admin,_member_
# serviceTenant	glance				admin
# serviceTenant	nova				admin
# serviceTenant	swift				admin
#
# demoTenant	demo		demopasswd	_member_
#
# testTenant	t-manager	managerpasswd	projectmanager
# testTenant	t-user1		userpasswd	_member_
# testTenant	t-user2		userpasswd	_member_

# TENANTs
ADMIN_TENANT_NAME=adminTenant
SERVICE_TENANT_NAME=serviceTenant
TEST_TENANT_NAME=testTenant
DEMO_TENANT_NAME=demoTenant

# ROLEs
ADMIN_ROLE_NAME=admin
SERVICE_ROLE_NAME=service
PM_ROLE_NAME=projectmanager

# USERs
ADMIN_USER_NAME=admin
ADMIN_PASSWORD=adminpasswd
ADMIN_EMAIL=admin@example.com

SERVICE_KEYSTONE_NAME=keystone
SERVICE_KEYSTONE_PASSWORD=keystonepasswd
SERVICE_GLANCE_NAME=glance
SERVICE_GLANCE_PASSWORD=glancepasswd
SERVICE_NOVA_NAME=nova
SERVICE_NOVA_PASSWORD=novapasswd
SERVICE_SWIFT_NAME=swift
SERVICE_SWIFT_PASSWORD=swiftpasswd

DEMO_USER_NAME=demo
DEMO_PASSWORD=demopasswd
DEMO_EMAIL=demo@example.com

TEST_MANAGER_NAME=t-manager
TEST_MANAGER_PASSWORD=managerpasswd
TEST_MANAGER_EMAIL=testpm@example.com

TEST_USER1_NAME=t-user1
TEST_USER1_PASSWORD=userpasswd
TEST_USER1_EMAIL=testuser1@example.com

TEST_USER2_NAME=t-user2
TEST_USER2_PASSWORD=userpasswd
TEST_USER2_EMAIL=testuser2@example.com

# Create tenants
echo "--- start create tenants"
keystone tenant-create --name $ADMIN_TENANT_NAME --description "Admin Tenant"
keystone tenant-create --name $SERVICE_TENANT_NAME --description "Service Tenant"
keystone tenant-create --name $DEMO_TENANT_NAME --description "Demo Tenant"
keystone tenant-create --name $TEST_TENANT_NAME --description "Test Tenant"

# Create roles
echo "--- start create roles"
keystone role-create --name $ADMIN_ROLE_NAME
keystone role-create --name $SERVICE_ROLE_NAME
keystone role-create --name $PM_ROLE_NAME

# Create user
# admin user
echo "--- create admin user"
keystone user-create 	--name $ADMIN_USER_NAME \
			--pass $ADMIN_PASSWORD \
			--email $ADMIN_EMAIL

# add admin user to admin role 
# and change from token authentication to user auth.
echo "--- add admin role to admin user"
keystone user-role-add 	--tenant $ADMIN_TENANT_NAME \
			--user $ADMIN_USER_NAME \
			--role $ADMIN_ROLE_NAME

# must enable identity service and endpoint before change from token to user auth.
keystone service-create --name keystone \
			--type identity \
			--description "OpenStack Identity"
keystone endpoint-create \
         --service $SERVICE_KEYSTONE_NAME \
         --publicurl http://${KEYSTONE_HOST}:5000/v2.0 \
         --internalurl http://${KEYSTONE_HOST}:5000/v2.0 \
         --adminurl http://${KEYSTONE_HOST}:35357/v2.0 \
         --region $REGION_NAME

echo "--- change auth. from token to admin user"
unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT
OS_USERNAME=$ADMIN_USER_NAME
OS_PASSWORD=$ADMIN_PASSWORD
OS_TENANT_NAME=$ADMIN_TENANT_NAME
OS_AUTH_URL=http://$KEYSTONE_HOST:35357/v2.0

# service users
echo "--- start create service users"
keystone user-create 	--name $SERVICE_KEYSTONE_NAME \
			--pass $SERVICE_KEYSTONE_PASSWORD
keystone user-create 	--name $SERVICE_GLANCE_NAME \
			--pass $SERVICE_GLANCE_PASSWORD
keystone user-create 	--name $SERVICE_NOVA_NAME \
			--pass $SERVICE_NOVA_PASSWORD
keystone user-create 	--name $SERVICE_SWIFT_NAME \
			--pass $SERVICE_SWIFT_PASSWORD
# demo user
echo "--- start create demo users"
keystone user-create 	--name $DEMO_USER_NAME \
			--tenant $DEMO_TENANT_NAME \
			--pass $DEMO_PASSWORD \
			--email $DEMO_EMAIL
# test users
echo "--- start create test users"
keystone user-create 	--name $TEST_MANAGER_NAME \
			--tenant $TEST_TENANT_NAME \
			--pass $TEST_MANAGER_PASSWORD \
			--email $TEST_MANAGER_EMAIL
keystone user-create 	--name $TEST_USER1_NAME \
			--tenant $TEST_TENANT_NAME \
			--pass $TEST_USER1_PASSWORD \
			--email $TEST_USER1_EMAIL
keystone user-create 	--name $TEST_USER2_NAME \
			--tenant $TEST_TENANT_NAME \
			--pass $TEST_USER2_PASSWORD \
			--email $TEST_USER2_EMAIL

# Create relationship of tenant-role-user
# admin can manage all tenant
echo "--- start assign admin role"
keystone user-role-add 	--tenant $SERVICE_TENANT_NAME \
			--user $ADMIN_USER_NAME \
			--role $ADMIN_ROLE_NAME
keystone user-role-add 	--tenant $DEMO_TENANT_NAME \
			--user $ADMIN_USER_NAME \
			--role $ADMIN_ROLE_NAME
keystone user-role-add 	--tenant $TEST_TENANT_NAME \
			--user $ADMIN_USER_NAME \
			--role $ADMIN_ROLE_NAME

# service user has service admin role
echo "--- start assign service role"
keystone user-role-add 	--tenant $SERVICE_TENANT_NAME \
			--user $SERVICE_KEYSTONE_NAME \
			--role $ADMIN_ROLE_NAME
keystone user-role-add 	--tenant $SERVICE_TENANT_NAME \
			--user $SERVICE_GLANCE_NAME \
			--role $ADMIN_ROLE_NAME
keystone user-role-add 	--tenant $SERVICE_TENANT_NAME \
			--user $SERVICE_NOVA_NAME \
			--role $ADMIN_ROLE_NAME
keystone user-role-add 	--tenant $SERVICE_TENANT_NAME \
			--user $SERVICE_SWIFT_NAME \
			--role $ADMIN_ROLE_NAME

# add for test env.
echo "--- start assign test role"
keystone user-role-add 	--tenant $TEST_TENANT_NAME \
			--user $TEST_MANAGER_NAME \
			--role $ADMIN_ROLE_NAME
keystone user-role-add 	--tenant $TEST_TENANT_NAME \
			--user $TEST_MANAGER_NAME \
			--role $PM_ROLE_NAME

# Create service 
echo "--- start create services"
keystone service-create --name glance \
			--type image \
			--description "OpenStack Image"
keystone service-create --name nova \
			--type compute \
			--description "OpenStack Compute"

# Create endpoint
echo "--- start create endpoints"
keystone endpoint-create \
         --service $SERVICE_GLANCE_NAME \
         --publicurl http://${GLANCE_HOST}:9292 \
         --internalurl http://${GLANCE_HOST}:9292 \
         --adminurl http://${GLANCE_HOST}:9292 \
         --region $REGION_NAME
keystone endpoint-create \
         --service $SERVICE_NOVA_NAME \
         --publicurl http://${NOVA_HOST}:8774/v2/%\(tenant_id\)s \
         --internalurl http://${NOVA_HOST}:8774/v2/%\(tenant_id\)s \
         --adminurl http://${NOVA_HOST}:8774/v2/%\(tenant_id\)s \
         --region $REGION_NAME

