#!/bin/sh  
fbranch=automation
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
# Variables
REPO_OWNER="nabad600"
REPO_NAME="apache_php"
BASE_BRANCH="master"  # The branch you want to merge into
HEAD_BRANCH="automation"    # The branch containing your changes
PR_TITLE="testing"
PR_BODY="Added renewed SSL certs"

# GitHub Personal Access Token (Replace with your token)
GITHUB_TOKEN="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"

# Create a pull request using the GitHub API
response=$(curl -X POST \
    -H "Authorization: token $GITHUB_TOKEN" \
    -d '{
        "title": "'"$PR_TITLE"'",
        "body": "'"$PR_BODY"'",
        "head": "'"$REPO_OWNER:$HEAD_BRANCH"'",
        "base": "'"$BASE_BRANCH"'"
    }' \
    "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/pulls")

# Extract the pull request URL from the API response
pr_url=$(echo "$response" | jq -r '.html_url')

echo "Pull request created: $pr_url"