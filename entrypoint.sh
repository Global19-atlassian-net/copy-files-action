#!/bin/sh -l

# Suggested by Github actions to be strict
set -e
set -o pipefail

if [[ -z "$INPUT_GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN env variable."
  exit 1
fi

echo $INPUT_GITHUB_TOKEN

git config --global url."https://$INPUT_GITHUB_TOKEN:@github.com/".insteadOf https://github.com/

git config --user.email "copy-files-action@solo.io"
git config --global user.name "copy-files-action"

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