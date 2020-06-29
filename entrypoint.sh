#!/bin/sh -l

# Suggested by Github actions to be strict
set -e
set -o pipefail

echo "Clone solo-apis..."
git clone https://github.com/solo-io/solo-apis.git

ls solo-apis

cp README.md solo-apis/README.md

cd solo-apis

git checkout -b test-action

git add .

git commit -m "test"

git push -u origin test-action