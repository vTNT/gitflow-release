#!/bin/bash

info=`git branch | grep -v develop | grep -v master | wc -l`
message="check failed,please check again!"

if [ "$1" = "patch" ]
then
    checkout_branch_name="master"
elif [ "$1" = "minor" -o "$1" = "major" ]
then
    checkout_branch_name="develop"
fi

function before_start () {
    git checkout master
    git checkout develop
 
    git checkout $checkout_branch_name

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
