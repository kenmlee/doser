#!/bin/sh

. ./rabbitmq-env.sh

# start a RabbitMQ server container 
docker run -d \
  --name $OPENSTACK_MQ \
  --hostname rabbitmq \
  -e RABBITMQ_NODENAME=$RABBITMQ_NODENAME \
  -p 15672:15672 \
  rabbitmq:management \
  rabbitmq-server

echo "Sleep 10 sec to make sure rabbitmq start up completely"
sleep 10

docker exec $OPENSTACK_MQ \
  su -c "${RABBITMQ_CTL} add_user ${RABBITMQ_USER} ${RABBITMQ_PASS}" rabbitmq
docker exec $OPENSTACK_MQ \
  su -c "${RABBITMQ_CTL} set_permissions openstack \".*\" \".*\" \".*\"" rabbitmq
