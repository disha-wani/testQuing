#! /bin/bash

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
DOCKM_HOME=$(dirname "${SCRIPTPATH}")

source "${DOCKM_HOME}/script/common.sh"

swarm_ready="false"
docker_ready="false"
if systemctl is-active docker
then
  docker_ready="true"
fi
if docker node ls > /dev/null 2>&1
then
    status=$(get_node_status)
    availability=$(get_node_availability)
    echo "ready:${status}"
    echo "active:${availability}"
    if [ "${status}" == "True" ] && [ "${availability}" == "True" ]
    then
        swarm_ready="true"
    fi
fi

if [ "${docker_ready}" == "true" ] && [ "${swarm_ready}" == "true" ]
then
  exit 0
else
  exit 1
fi