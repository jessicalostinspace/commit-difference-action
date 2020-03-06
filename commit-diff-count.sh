#!/bin/bash
set -eoux pipefail

baseBranch=$1
secondaryBranch=$2
circumflex=^

commitDiffCount=''

baseBranchPath=$(git branch -r | grep $baseBranch)
secondaryBranchPath=$(git branch -r | grep $secondaryBranch)

commitDiffCount=$(echo $(git log --oneline $secondaryBranchPath $circumflex$baseBranchPath | wc -l))

echo '{"commitDiffCount": "'$commitDiffCount'"}' 
