#!/bin/sh -l

# Key scan for github.com
ssh-keyscan github.com > /root/.ssh/known_hosts

# Set ssh key for subtree
echo "${INPUT_REPO_KEY}" >> /root/.ssh/repo_key
chmod 0600 /root/.ssh/repo_key

echo "${INPUT_DEPLOY_KEY}" >> /root/.ssh/deploy_key
chmod 0600 /root/.ssh/deploy_key

eval $(ssh-agent -s)

ssh-add /root/.ssh/deploy_key
ssh-add /root/.ssh/repo_key

# Get subtree repository into split directory
git clone git@github.com:"${INPUT_MAIN_REPO}".git /tmp/split

cd /tmp/split

git subtree push --prefix web "${INPUT_DOKKU_REPO}" master
