## Introduction

Perhaps most of developers are familiar with git-flow model, that makes release process controlled. In this article I would demonstrate one of approaches to introduce git-flow releasing in your project, capable to be integrated with continious integration tool of your choice

## Background

If you never heard about git-flow previously, I suggest to study classic post [http://nvie.com/posts/a-successful-git-branching-model/](http://nvie.com/posts/a-successful-git-branching-model/) && how Atlassian interpret the same idea [https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)

For those, who aware, let me remind well known diagram:

![](https://raw.githubusercontent.com/vtnt/gitflow-release/master/images/git-workflow-release-cycle-4maintenance.png)

## Installation
```
curl -OL https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh
bash gitflow-installer.sh 
bash install.sh
```

## Usage
```
1. bash start-release.sh -p project_name -version <patch/minor/major> ; the default value is patch

2. bash finish-release.sh -p project_name
```

#### bump-version-drynext.sh
```
version have three type: patch/minor/major, the default type is minor
patch mean: 0.0.1 -> 0.0.2, and create hotfix branch
minor mean: 0.0.1 -> 0.1.0, and create release branch 
major mean: 0.0.1 -> 1.0.0, and create release branch

```
#### note
1. you can fork this project to modify;
2. start-release.sh has supported create hotfix branch now;
