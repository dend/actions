#!/bin/bash -l
shopt -s extglob

apt-get update
apt-get install -y wget git
apt-get install -y nodejs npm

npm install uglifycss -g

wget $HUGO_URL

yes | dpkg -i hugo*.deb

hugo version

# Make sure we have the latest theme.
if [ -z ${LOCAL_THEME_GIT_URL+x} ]; then echo "No theme specified."; else git clone --progress --verbose https://$BLOG_DEPLOY_KEY@$LOCAL_THEME_GIT_URL $LOCAL_THEME_LOCATION --depth 1; fi
git clone --progress --verbose https://$BLOG_DEPLOY_KEY@$BLOG_PUBLISH_URL $BLOG_PUBLISH_LOCATION --depth 1

cd $BLOG_FOLDER
hugo -v

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

echo "Removing content..."
rm -rf ../$BLOG_PUBLISH_LOCATION/!("CNAME"|".git")
echo "Content removal completed."
cp -a public/. ../$BLOG_PUBLISH_LOCATION/
cd ../$BLOG_PUBLISH_LOCATION
echo "In blog publishing folder."
ls
git add .
git commit -m "Update content."
git push

git branch
