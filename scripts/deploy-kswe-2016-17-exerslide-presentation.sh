#!/bin/bash

. "$0".config

TIMESTAMP=$(date "+%Y%m%d%H%M%S")
REPO=${CONFIG_REPO}
REPODIR="/tmp/kswe-2016-17-exerslide-${TIMESTAMP}"

echo "Cloning repository ... "
git clone ${REPO} ${REPODIR}
echo "Cloning repository ... [done]"

echo "Entering presentation directory ..."
cd ${REPODIR}/presentation
echo "Entering presentation directory ... [done]"

echo "Setting git config ..."
git config user.name "${CONFIG_GIT_USER_NAME}"
git config user.email "${CONFIG_GIT_USER_EMAIL}"
echo "Setting git config ... [done]"

echo "Building presentation ..."
npm run build
echo "Building presentation ... [done]"

echo "Backing up built presentation ..."
cd ${REPODIR}

mv presentation/out ${REPODIR}-out
echo "Backing up built presentation ... [done]"

echo "Cleaning up repository ..."
rm -rf presentation

git reset --hard
echo "Cleaning up repository ... [done]"

echo "Checking out gh-pages branch ..."
git checkout gh-pages
echo "Checking out gh-pages branch ... [done]"

echo "Moving built presentation to target place ..."
mv ${REPODIR}-out/* ${REPODIR}
echo "Moving built presentation to target place ... [done]"

echo "Committing built presentation ..."
git add .
git commit -m "Deploy updated presentation by webhook"
echo "Committing built presentation ... [done]"

echo "Pushing updated webpage ..."
git push origin gh-pages
echo "Pushing updated webpage ... [done]"
