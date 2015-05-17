#!/bin/sh

# start a glance client container
docker run -it 	 --link keystone:keystone \
                 --link glance:glance \
		 --rm \
		 --name glanceclient \
		 kenlee/openstack-client

