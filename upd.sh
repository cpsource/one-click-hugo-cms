#!/bin/bash
if [ $# -eq 1 ]
  then
      COMMIT="$1"
else
      COMMIT="trial"    
fi

pushd site
../bin/hugo.linux -D
if [ $? -eq 0 ]; then
    echo Site Builds - OK
else
    echo Site Failed, exiting - FAIL
fi
popd

git add -A
git commit -m "$COMMIT"
git push ssh
