#!/bin/bash -l

CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)

apt-get update
apt-get install -y python-setuptools wget python-pip git

wget https://github.com/gohugoio/hugo/releases/download/v0.52/hugo_0.52_Linux-64bit.deb

yes | dpkg -i hugo*.deb

hugo version

# Make sure we have the latest theme.
git clone --progress --verbose https://$BLOG_DEPLOY_KEY@github.com/dend/hugo-modern-theme.git dennisdel/themes/modern

cd dennisdel
hugo -v

if [ "$CURRENT_BRANCH" = "master" ]; 
then
  echo "Running on master - we need a deployment."

  # Install AWS CLI
  pip install wheel
  pip install awscli --upgrade --user

  export PATH=~/.local/bin:/usr/bin/python:$PATH

  # Configure AWS CLI
  aws --version
  aws configure set aws_access_key_id $AWS_ACCESS_KEY
  aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
  aws configure set default.region $AWS_DEFAULT_REGION
  aws configure set preview.cloudfront true

  # Deploy changes
  set -e

  DISTRIBUTION_ID=E2Q31E8QXDW2Z2
  AWS_BUCKET_NAME=dennisdel.com-cdn

  # Copy over pages - not static js/img/css/downloads
  aws s3 sync --acl "public-read" --sse "AES256" public/ s3://$AWS_BUCKET_NAME/ --exclude 'img' --exclude 'js' --exclude 'downloads' --exclude 'css' --exclude 'post'

  # Ensure static files are set to cache forever - cache for a month --cache-control "max-age=2592000"
  aws s3 sync --cache-control "max-age=2592000" --acl "public-read" --sse "AES256" public/img/ s3://$AWS_BUCKET_NAME/img/
  aws s3 sync --cache-control "max-age=2592000" --acl "public-read" --sse "AES256" public/css/ s3://$AWS_BUCKET_NAME/css/
  # aws s3 sync --cache-control "max-age=2592000" --acl "public-read" --sse "AES256" public/js/ s3://$AWS_BUCKET_NAME/js/

  # Downloads binaries, not part of repo - cache at edge for a year --cache-control "max-age=31536000"
  aws s3 sync --cache-control "max-age=31536000" --acl "public-read" --sse "AES256"  public/ s3://$AWS_BUCKET_NAME

  # Invalidate landing page so everything sees new post - warning, first 1K/mo free, then 1/2 cent ea
  aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths /index.html / /blog/* /blog/index.html /* /about/* /gear/* /speaking/* /css/*
else
  echo "Not master - we don't need a deployment, just validated the content."
fi

git branch

echo "Current branch:"
echo $CURRENT_BRANCH
