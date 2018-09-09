#!/bin/bash

curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
yum install -y git python-pip yarn
pip install shyaml
npm install gulp-cli -g
