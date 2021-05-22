#!/bin/bash -l

apt-get update
apt-get install -y wget git curl

curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs

echo "Installing Uglify"
npm install -g uglifycss
echo "Installing PostCSS"
npm install -g postcss postcss-cli
echo "Installing PurgeCSS"
npm install -g @fullhuman/postcss-purgecss

wget $HUGO_URL

yes | dpkg -i hugo*.deb

hugo version

cd $BLOG_FOLDER
npm i -D @fullhuman/postcss-purgecss postcss
echo "Checking content of local folder."
ls
hugo -v

ls
