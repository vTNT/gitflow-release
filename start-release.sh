#!/bin/bash

SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)

function usage (){
    echo "the correct command is: start-release.sh -p project_name -version <patch/minor/major>"
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
        -version | --version ) shift
            version=$1
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

if [ -z "$version" ]
then
   version=minor
fi

cd ${SHELL_FOLDER}

if [ ! -d "project/$project" ];
then
    mkdir -p "project"/${project}
    cd "project/$project"
    git clone -b develop git@github.com:vtnt/"$project".git .
else
    cd "project/$project"
    git pull --all
fi

#CHECK
source ../../check.sh
before_start || exit 1

NEXTVERSION=`../../bump-version-drynext.sh ${version}`

if [ "$verison" = "patch" ]
then
    echo "sorry, didn't support create hotfix branch"
elif [ "$version" = "minor" -o "$version" = "major" ]
then
    ../../release_start.sh $NEXTVERSION
else
    echo "please input right version"
fi
