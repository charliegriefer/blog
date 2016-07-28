#!/bin/bash

echo -e "\033[0;32mDeploying updates to Github...\033[0m"

# echo -e "\033[0;32mRemoving 'public' directory...\033[0m"
# rm -rf public # Ensure the public folder is gone

# let's assume we pushed the Hugo files.
# echo -e "\033[0;32mPushing Hugo files...\033[0m"
# git add .
# git push -u origin master

echo -e "\033[0;32mRegenerating HTML and pushing submodule...\033[0m"
hugo # Build the project

echo -e "\033[0;32mChanging to newly created 'public' directory...\033[0m"
cd public # Move to the public dir

echo -e "\033[0;32mRunning git add ....\033[0m"
git add . # Add changes to git.

echo -e "\033[0;32mRunning git commit...\033[0m"
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg" # Commit changes.

echo -e "\033[0;32mPushing origin master...\033[0m"
git push origin master # Push source and build repos.

echo -e "\033[0;32mMoving out of 'public' directory...\033[0m"
cd .. # change up into the parent level directory

# echo -e "\033[0;32mRemoving public directory...\033[0m"
# rm -rf public # Ensure the public folder is gone
