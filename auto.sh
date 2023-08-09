#!/bin/sh  
fbranch=test
echo $fbranch
if [ $branch == $fbranch ]
then
    echo "Branch is currect"
else
    echo "Branch is not currect"
    git checkout $fbranch
fi
branch=$(git symbolic-ref --short HEAD)
echo $branch
git add .
commit="Added renewed SSL certs"
echo $commit
git commit -m "$commit"
git push origin $branch

