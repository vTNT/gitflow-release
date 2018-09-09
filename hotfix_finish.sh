#!/bin/sh

# PREVENT INTERACTIVE MERGE MESSAGE PROMPT AT A FINAL STEP
GIT_MERGE_AUTOEDIT=no
export GIT_MERGE_AUTOEDIT

GITBRANCHFULL=`git rev-parse --abbrev-ref HEAD`
GITBRANCH=`echo "$GITBRANCHFULL" | cut -d "/" -f 1`
HOTFIXTAG=`echo "$GITBRANCHFULL" | cut -d "/" -f 2`

echo $GITBRANCH
echo $HOTFIXTAG

if [ $GITBRANCH != "hotfix" ]
then
    echo "Release can be finished only on hotfix branch!"
    return 1
fi

if [ -z $HOTFIXTAG ]
then
    echo "We expect gitflow to be followed, make sure hotfix branch called hotfix/x.x.x.x"
    exit 1
fi

git pull origin $GITBRANCH/$HOTFIXTAG

#Initialize gitflow
git flow init -f -d

# ensure you are on latest develop  & master and return back
git checkout develop
git pull origin develop
git checkout -

git checkout master
git pull origin master
git checkout -

git flow hotfix finish -m "hotfix $HOTFIXTAG" $HOTFIXTAG

git push origin develop && git push origin master --tags

#DELETE REMOTE HOTFIX BRANCH
git branch -r -d origin/$GITBRANCH/$HOTFIXTAG
git push origin :$GITBRANCH/$HOTFIXTAG

git checkout develop
