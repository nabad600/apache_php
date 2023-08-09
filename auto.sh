#!/bin/sh  
fbranch=test
username='nabad600'
password='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'
branch=$(git symbolic-ref --short HEAD)
echo $branch
echo $username
echo $password
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

# curl \
#   -X POST \
#   -H "Accept: application/vnd.github.v3+json" \
#   https://api.github.com/repos/nabad600/apache_php/pulls \
#   -d '{"head":"copyright_updater","base":"master"}' 
# request_base_url=`git remote -v show | tr '\n' ' ' | perl -pe 's|.*${REMOTE}\s+?git@(.*?):(.*?)\.git\s+?\(push\).*|http://\1/\2/pull/new/|'`
# echo $request_base_url
# pull_request_url=${request_base_url}
# open $pull_request_url
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

# put this in your .bash_profile
# pull_request() {
#   to_branch=$1
#   if [ -z $to_branch ]; then
#     to_branch="master"
#   fi
  
#   # try the upstream branch if possible, otherwise origin will do
#   upstream=$(git config --get remote.upstream.url)
#   origin=$(git config --get remote.origin.url)
#   if [ -z $upstream ]; then
#     upstream=$origin
#   fi
  
#   to_user=$(echo $upstream | sed -e 's/.*[\/:]\([^/]*\)\/[^/]*$/\1/')
#   from_user=$(echo $origin | sed -e 's/.*[\/:]\([^/]*\)\/[^/]*$/\1/')
#   repo=$(basename `git rev-parse --show-toplevel`)
#   from_branch=$(git rev-parse --abbrev-ref HEAD)
#   open "https://github.com/$to_user/$repo/pull/new/$to_user:$to_branch...$from_user:$from_branch"
# }
 
# # usage
# pull_request              # PR to master
# pull_request other_branch # PR to other_branch