#!/bin/bash

echo -e "\033[0;32mDeploying updates to Github...\033[0m"

# Ensure the public folder is gone
rm -rf public

# Build the project.
hugo

# Move to the public dir
cd public

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
git subtree push --prefix=public git@github.com:charliegriefer/charliegriefer.github.io public
