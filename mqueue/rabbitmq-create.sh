#!/bin/sh

. ./rabbitmq-env.sh

# start a RabbitMQ server container 
docker run -d \
  --name $OPENSTACK_MQ \
  --hostname rabbitmq \
  -e RABBITMQ_NODENAME=$RABBITMQ_NODENAME \
  -p 15672:15672 \
  rabbitmq:management

