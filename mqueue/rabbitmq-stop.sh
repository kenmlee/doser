#!/bin/sh

. ./rabbitmq-env.sh

# stop RabbitMQ server container
docker stop $OPENSTACK_MQ 
