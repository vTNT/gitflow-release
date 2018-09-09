#!/bin/bash

master_status=`git branch | grep master | wc -l`
info=`git branch | grep -v develop | grep -v master | wc -l`
message="check failed,please check again!"

function before_start () {
    if [ "${master_status}" -eq 0 ]
    then
        git checkout master
        git checkout develop
    fi

    if [ "${info}" -ne 0 ]
    then
        echo -e "${message}"
        exit 1
    fi 
}

function before_finish () {
    if [ "${info}" -ne 1 ]
    then
        echo -e "${message}"
        exit 1
    fi
}
