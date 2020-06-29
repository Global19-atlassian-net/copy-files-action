#!/bin/sh

# Suggested by Github actions to be strict
set -e
set -o pipefail

if [[ -z "$INPUT_GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN input."
  exit 1
fi

git config --global url."https://$INPUT_GITHUB_TOKEN:@github.com/".insteadOf https://github.com/

git config --global user.email "copy-files-action@solo.io"
git config --global user.name "copy-files-action"

echo "Actor: $GITHUB_ACTOR"
echo "Workflow: $GITHUB_WORKFLOW"
echo "Event name: $GITHUB_EVENT_NAME"
echo "Event path: $GITHUB_EVENT_PATH"

event_payload=$(jq --raw-output . "$GITHUB_EVENT_PATH")
echo "$event_payload"

echo "Cloning solo-apis repository..."
git clone https://github.com/solo-io/solo-apis.git

ls solo-apis

cp README.md solo-apis/README.md

cd solo-apis

echo "pwd"
pwd

git checkout -b test-action

git add .

git status

echo "Commit..."
git commit -m "test"

echo "Push..."
git push -u origin test-action

echo "Done"