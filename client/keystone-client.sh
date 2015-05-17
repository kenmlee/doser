#!/bin/sh

# start a keystone client container

docker run -it  --rm \
		--link keystone:keystone \
		--name keystoneclient \
		kenlee/openstack-client

