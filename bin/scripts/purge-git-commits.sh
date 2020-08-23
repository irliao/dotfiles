#!/bin/sh

# NOTE: this script will remove all commit messages once pushed to GitHub
# reference: http://stackoverflow.com/questions/13716658/how-to-delete-all-commit-history-in-github

git checkout --orphan latest_branch

git add -A

git commit -am "initial commit"

git branch -D master

git branch -m master

echo "run: 'git push -f origin master' to apply purge"
