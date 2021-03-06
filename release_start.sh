#!/bin/bash

VERSION=$1
LANGUAGE=$2
ACTION=$3

if [ -z $1 ]
then
    echo "please input version num"
    exit 1
fi

#Initialize gitflow
git flow init -f -d

# ensure you are on latest develop  & master
git checkout develop
git pull origin develop
git checkout -

git checkout master
git pull origin master
git checkout develop

git flow release start $VERSION # checkout release branch

# COMMENT LINES BELOW IF YOU BUMP VERSION AT THE END
../../bump-version.sh $VERSION
 
#SUPPORT NODEJS
if [ $LANGUAGE = "nodejs" ] 
then
    yarn install
    gulp bump --level $ACTION
fi

git commit -am "Bumps version to $VERSION"
git push origin release/$VERSION
