#!/bin/sh -l

# Key scan for github.com
ssh-keyscan github.com > /root/.ssh/known_hosts

# Set ssh key for subtree
echo "${INPUT_SUBTREE_DEPLOY_KEY}" >> /root/.ssh/subtree
chmod 0600 /root/.ssh/subtree

eval $(ssh-agent -s)

ssh-add /root/.ssh/subtree

# Get subtree repository into split directory
git clone git@github.com:"${INPUT_MAINREPO}".git /tmp/split

cd /tmp/split

git subtree push --prefix web git@github.com:"${INPUT_SUBTREEREPO}".git master
