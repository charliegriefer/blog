+++
author = ""
categories = ["Hugo", "Github Pages", "Go"]
date = "2016-07-29T19:11:09-07:00"
description = "Setting up Hugo to use Github Pages"
featured = ""
featuredalt = ""
featuredpath = ""
linktitle = ""
title = "Hugo on Github Pages"
type = "post"
+++

## Hugo on Github Pages

A couple of years ago, I learned of [Jekyll](https://jekyllrb.com) and [Github Pages](https://pages.github.com). I was immediately hooked
on the idea. The notion of a simple, static blog as opposed to the (_warning: opinion_) bloated and insecure WordPress option, was incredibly appealing to me. I'm not a Ruby person, but Jekyll was fairly straightforward to set up and run locally. Having a free site in the form of Github Pages gave me a place to blog about techie stuff. And of course, it worked seamlessly with Jekyll. I'd just upload my Jekyll files, and Github Pages would automatically generate and serve the static pages.

Fast forward to today. I recently accepted a new position with [Wrecking Ball Studio + Labs](http://www.getwrecked.com), where I'll be learning about and using Google's [Go](https://golang.org). Time to repurpose the blog. And as it turns out, there's a static blog engine written in Go. Time to look at [Hugo](https://gohugo.io).

At first glance, Hugo's pretty cool, and straightforward to install and run. I appreciate that it's written in the language that I'll be using on a day-to-day basis. I was never a Ruby developer, and recall being frustrated at times dealing with certain Jekyll dependencies (what the hell is a "gem", even?). I can get a blog up and running fairly quickly.

But taking advantage of Github Pages for hosting... that's where I ran into some obstacles.

Github Pages and Jekyll were made to work together. I maintained a [single repository](https://github.com/charliegriefer/charliegriefer.github.io) where I uploaded the Jekyll source files. Those source files were automagically converted into static pages. Easy peasy.

Working with Hugo and Github Pages wasn't quite so easy. There are no shortage of Google search results on using Hugo and Github Pages, but the accuracy of the search results seemed to vary wildly. Some suggested that Github Pages would publish static pages that were committed to a `gh-pages` branch. This may have been true at one point, and might even still be true today for Project Pages, but is apparently no longer true for User Pages (see https://help.github.com/articles/user-organization-and-project-pages/).

It became evident that, if I wanted to continue serving up my blog via Github Pages, that I'd need to maintain two distinct repositories. [One for the Hugo source files](https://github.com/charliegriefer/hugo-blog), and [one for the static pages](https://github.com/charliegriefer/charliegriefer.github.io). That meant two commits to two repositories. Having gotten used to the single-commit Jekyll method, I wanted to simplify the Hugo process as much as possible.

I tried declaring the `charliegriefer.github.io` repository as a submodule to the `hugo-blog` repository, but that turned out to be anything other than simple. This might be due to my lack of familiarity around submodules, but I felt that I was adding more complexity rather than simplifying the process.

I finally relented and simply let the two repositories live two separate lives. They really do serve two different purposes.

[Todd Rafferty](https://twitter.com/webrat), co-worker at Wrecking Ball and all around Go Guru, suggested that he `gitignore`s Hugo's `public` folder (the folder where the static pages reside), and only commits the Hugo files. He FTPs the static files from the `public` folder up to S3 where he hosts them.

I went a similar route, but I'm still hosting up on Github using Github Pages.

As I work with the Hugo files, they get saved and committed to the `hugo-blog` repository. Once I'm done, I run the following bash script (which is also saved and committed to the `hugo-blog` repository as `deploy.sh`):

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

This gets run from the `hugo-blog` directory. When the `hugo` command is run, I use the `-d` flag to specify that the files are saved one level up to the `charliegriefer.github.io` directory.

From there I commit the files with a static commit message (other than adding a date stamp), and pushing the files to the `charliegriefer.github.io` repository.

It's still a lot of steps, but I feel better for having hidden them into a single `./deploy.sh` command. Cheating? Maybe. But to me it's working smarter and not harder.
