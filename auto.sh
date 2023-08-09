#!/bin/sh  
fbranch=test
username='nabad600'
password='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'
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
# PR create
data=$(cat <<-END
{
  "base": "master",
  "head": "$branch",
  "body": "$commit"
}
END
)
status_code=$(curl -s --user "$username:$password" -X POST "https://api.github.com/repos/ccnokes/git-automation-sandbox/pulls" -d "$data" -w %{http_code} -o /dev/null)

if [[ $status_code == "201" ]]; then
  echo "Complete!"
else
  echo "Error occurred, $status_code status received" >&2
  exit 1
fi