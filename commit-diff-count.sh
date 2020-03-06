#!/bin/bash
set -eoux pipefail

baseBranch=$1
secondaryBranch=$2

commitDiffCount=''

baseBranchPath=$(git branch -r | grep "$baseBranch" | xargs)
secondaryBranchPath=$(git branch -r | grep "$secondaryBranch")

commitDiffCount=$(git log --oneline "$secondaryBranchPath" \^"$baseBranchPath" | wc -l)

echo '{"commitDiffCount": "'"$commitDiffCount"'"}' 
