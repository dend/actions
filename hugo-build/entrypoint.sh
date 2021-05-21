#!/bin/bash -l

apt-get update
apt-get install -y wget git
apt-get install -y nodejs npm

npm install uglifycss -g

wget $HUGO_URL

yes | dpkg -i hugo*.deb

hugo version

cd $BLOG_FOLDER
echo "Checking content of local folder."
ls
hugo -v

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

ls
