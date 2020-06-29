#!/bin/sh -l

# Suggested by Github actions to be strict
set -e
set -o pipefail

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN env variable."
  exit 1
fi

RUN git config --global url."https://$GITHUB_TOKEN:@github.com/".insteadOf https://github.com/

echo "Clone solo-apis..."
git clone https://github.com/solo-io/solo-apis.git

ls solo-apis

cp README.md solo-apis/README.md

cd solo-apis

echo "pwd"
pwd

git checkout -b test-action

git add .

git status

git commit -m "test"

git push -u origin test-action