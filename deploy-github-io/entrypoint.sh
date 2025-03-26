#!/bin/bash -l
set -e  # Exit on errors
set -o pipefail  # Ensure pipeline failures are detected
shopt -s extglob

trap 'handle_error $LINENO $?' ERR

handle_error() {
    local lineno=$1
    local exit_code=$2
    local command="${BASH_COMMAND}"
    local error_message=$(tail -n 1 /tmp/error_log || echo "No error message captured")
    echo "::error file=${BASH_SOURCE[1]},line=$lineno::Command '$command' failed with exit code $exit_code. Error: $error_message"
    exit $exit_code
}

# Redirect stderr to a log file for capturing error messages
exec 2>/tmp/error_log

apt-get update
apt-get install -y wget git
apt-get install -y nodejs npm

npm install uglifycss -g

wget $HUGO_URL

yes | dpkg -i hugo*.deb || echo "::warning::dpkg encountered a non-critical issue."

hugo version

# Make sure we have the latest theme.
if [ -z ${LOCAL_THEME_GIT_URL+x} ]; then echo "No theme specified."; else git clone --progress --verbose https://$BLOG_DEPLOY_KEY@$LOCAL_THEME_GIT_URL $LOCAL_THEME_LOCATION --depth 1; fi
git clone --progress --verbose https://$BLOG_DEPLOY_KEY@$BLOG_PUBLISH_URL $BLOG_PUBLISH_LOCATION --depth 1

cd $BLOG_FOLDER
echo "Checking content of local folder."
ls
hugo build

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

echo "Inspecting blog location contents:"
ls ../$BLOG_PUBLISH_LOCATION
echo "Removing content..."
find ../$BLOG_PUBLISH_LOCATION -mindepth 1 -maxdepth 1 ! -name 'CNAME' ! -name '.git' -exec rm -rf {} +
echo "Content removal completed."
cp -a public/. ../$BLOG_PUBLISH_LOCATION/
cd ../$BLOG_PUBLISH_LOCATION
echo "In blog publishing folder."
ls
git add .
git commit -m "Update content."
git push

git branch
