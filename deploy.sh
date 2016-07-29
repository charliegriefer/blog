#!/bin/bash

echo -e "\033[0;32mDeploying new blog...\033[0m"

echo -e "\033[0;32mDeleting old site...\033[0m"
rm -rf ~/src/charliegriefer.github.io/posts/

echo -e "\033[0;32mRunning hugo...\033[0m"
hugo -d ../charliegriefer.github.io

echo -e "\033[0;32mChanging to blog directory...\033[0m"
cd ../charliegriefer.github.io

echo -e "\033[0;32mCommit and push the new build...\033[0m"
git commit -am "New Blog Build (`date`)"
git push

echo -e "\033[0;32mChange back to hugo-blog...\033[0m"
cd ../hugo-blog

echo -e "\033[0;32mDeploy complete.\033[0m"
