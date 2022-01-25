#!/bin/bash
pushd site
../bin/hugo.linux -D
if [ $? -eq 0 ]; then
    echo Site Builds - OK
else
    echo Site Failed, exiting - FAIL
fi

git add -A
git commit -m "trial"
git push ssh
