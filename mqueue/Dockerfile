# RabbitMQ container for OpenStack by Ken Lee
#
# Version: 0.0.1
FROM rabbitmq:management
MAINTAINER Ken Lee "kenmlee@163.com"

ENV REFRESHED_AT 2015-04-30

# add a log volume
# The rabbitmq use user 'rabbitmq' as the owner of log directory.
# But, docker mount volume as owner of root each time when start a container
#VOLUME ["/var/log/rabbitmq"]
#RUN ["chown", "-R", "rabbitmq:rabbitmq", "/var/log/rabbitmq"]
USER rabbitmq
RUN /usr/lib/rabbitmq/bin/rabbitmqctl add_user openstack rabbitpasswd
#RUN rabbitmqctl set_permissions openstack ".*" ".*" ".*"
