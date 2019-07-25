#!/bin/bash
cd /var/www/documentation
git stash
rm -rf site
git pull --force
mkdocs build
cd /var/www/html
#git stash
git pull --force
cd /var/www/blog
git stash
git pull --force
bundle exec jekyll build
cd /var/www/parrot-unipa-website
git stash
git pull --force
bundle exec jekyll build
cd /var/www/vscodium
git stash
git pull --force
jekyll build
cd /var/www
