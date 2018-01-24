#!/bin/bash

LOG_FILE="/logs/cluster_logs"
mkdir -p "$(dirname "$LOG_FILE")"
touch "$LOG_FILE"

function log_info {
    log_common "INFO" $1
}

function log_warn {
    log_common "WARN" $1
}

function log_error {
    log_common "ERROR" $1
}

function log_common {
    dt=$(date '+%F %T')
    echo "[$1]: $dt--- $2" &>> ${LOG_FILE}
}

function mydocker(){
    docker $*
}

function get_node_status(){
  if [ "$(mydocker node ls | awk '{print $4}' | grep -v 'none' | grep -iv 'availability')" = "Ready" ]
  then
    status = "True"
    echo ${status}
  fi
}
function get_node_availability(){
   if [ "$(mydocker node ls | awk '{print $5}' | grep -v 'none' | grep -iv 'manager')" = "Active" ]
   then
     availability = "True"
     echo ${availability}
   fi

}