#!/bin/sh -l

# Key scan for github.com
ssh-keyscan github.com > /root/.ssh/known_hosts

# Set ssh key for subtree
echo "${INPUT_SUBTREE_DEPLOY_KEY}" >> /root/.ssh/subtree
chmod 0600 /root/.ssh/subtree

# Get subtree repository into split directory
git clone https://github.com/"${INPUT_SUBTREE}" /tmp/split

cd /tmp/split

echo $(ls)

git subtree push --prefix web https://github.com/Schreglmann/subtreeweb master
