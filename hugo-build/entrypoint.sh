#!/bin/bash -l

apt-get update
apt-get install -y wget git curl

curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs

echo "Installing Uglify"
npm install -g uglifycss --loglevel verbose
echo "Installing PostCSS"
npm install -g postcss postcss-cli --loglevel verbose
echo "Installing PurgeCSS"
npm install -g @fullhuman/postcss-purgecss --loglevel verbose
npm install -g postcss-import

wget $HUGO_URL

yes | dpkg -i hugo*.deb

hugo version

cd $BLOG_FOLDER
npm i -D @fullhuman/postcss-purgecss postcss --loglevel verbose

echo "Checking content of local folder."
ls
hugo -v

ls
