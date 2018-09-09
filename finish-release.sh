#!/bin/bash

SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)

function usage (){
    echo "the correct command is: finish-release.sh -p project_name"
}

if [ $# -eq 0 ];then
    usage
    exit 1
fi

while [ "$1" != "" ]; do
    case $1 in
        -p | --project ) shift
            project=$1
            ;;
        -h | --help )
            usage
            exit
            ;;
        * )
            usage
            exit 1
    esac
    shift
done

cd ${SHELL_FOLDER}

if [ -d "project/$project" ];
then
    cd "project/$project"
else
    echo -e "can't find project,please check!"
    exit 1
fi

#CHECK
source ../../check.sh
before_finish || exit 1

GITBRANCHFULL=`git rev-parse --abbrev-ref HEAD`
GITBRANCH=`echo "$GITBRANCHFULL" | cut -d "/" -f 1`

if [ "$GITBRANCH" = "hotfix" ]
then
    ../../hotfix_finish.sh
elif [ "$GITBRANCH" = "release" ]
then
    ../../release_finish.sh 
else
    echo -e "Release can be finished only on release/hotfix branch!"
    exit 1 
fi
