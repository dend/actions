#!/bin/bash -l
shopt -s extglob

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

echo "Inspecting blog location contents:"
ls ../$BLOG_PUBLISH_LOCATION
echo "Removing content..."
rm -rf ../$BLOG_PUBLISH_LOCATION/!("CNAME"|".git")
echo "Content removal completed."
cp -a public/. ../$BLOG_PUBLISH_LOCATION/
cd ../$BLOG_PUBLISH_LOCATION
echo "In blog publishing folder."
ls
