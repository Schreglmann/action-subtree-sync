#!/bin/sh -l

# Key scan for github.com
ssh-keyscan github.com > /root/.ssh/known_hosts

# Set ssh key for subtree
echo "${INPUT_SUBTREE_DEPLOY_KEY}" >> /root/.ssh/subtree
chmod 0600 /root/.ssh/subtree

ssh-add /root/.ssh/subtree

git config --global user.name "Deployment"
git config --global user.email "georgschreglmann@gmx.at"

# Get subtree repository into split directory
git clone git@github.com:schreglmann/testproject.git /tmp/split

cd /tmp/split

git subtree push --prefix web git@github.com:Schreglmann/subtreeweb.git master
