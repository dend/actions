#!/bin/bash -l

apt-get update
apt-get install -y wget git

CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)

wget $HUGO_URL

yes | dpkg -i hugo*.deb

hugo version

# Make sure we have the latest theme.
git clone --progress --verbose https://$BLOG_DEPLOY_KEY@$LOCAL_THEME_GIT_URL $LOCAL_THEME_LOCATION
git clone --progress --verbose https://$BLOG_DEPLOY_KEY@$BLOG_PUBLISH_URL $BLOG_PUBLISH_LOCATION


cd $BLOG_FOLDER
hugo -v

if [ "$CURRENT_BRANCH" = "master" ]; 
then
  git config --global user.email "$GIT_EMAIL"
  git config --global user.name "$GIT_NAME"

  rm -rf $BLOG_PUBLISH_LOCATION/*
  cp -a public/. ../$BLOG_PUBLISH_LOCATION/
  cd ../$BLOG_PUBLISH_LOCATION
  git add .
  git commit -m "Update content."
  git push
else
  echo "Not master - we don't need a deployment, just validated the content."
fi

git branch

echo "Current branch:"
echo $CURRENT_BRANCH