#!/bin/sh

git stash save --include-untracked || exit $?
echo "======================================================================"
stack build || exit $?
echo "======================================================================"
stack exec k12a-website rebuild || exit $?
echo "======================================================================"
rsync --archive --verbose --compress --delete _site/ kier@k12a.kierdavis.com:/var/www/k12a.kierdavis.com/www/htdocs/ || exit $?
echo "======================================================================"
git stash pop || exit $?
