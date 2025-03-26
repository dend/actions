#!/bin/sh -l

apt-get update
apt-get install -y curl gnupg gnupg2 gnupg1 git
curl -sL https://deb.nodesource.com/setup_11.x | bash -
apt-get install -y nodejs npm
npm install typedoc --save-dev --global
npm install type2docfx --save-dev --global
mkdir _package
rm -rf docs/api/*.yml
npm install $TARGET_PACKAGE --prefix _package
typedoc --mode file --json _output.json _package/node_modules/${TARGET_PACKAGE}/${TARGET_SOURCE_PATH} --ignoreCompilerErrors --includeDeclarations --excludeExternals
type2docfx _output.json docs/api/

echo "_package/node_modules/${TARGET_PACKAGE}/${TARGET_SOURCE_PATH}"

# Do some cleanup.
rm -rf _package
rm -rf _output.json

# Check in changes.
git config --global user.email "$GH_EMAIL"
git config --global user.name "$GH_USER"

git add . --force
git status
git commit -m "Update auto-generated documentation."
git push --set-upstream origin master
