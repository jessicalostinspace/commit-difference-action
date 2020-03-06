#!/bin/bash
set -eoux pipefail

baseBranch=$1
secondaryBranch=$2

commitDiffCount=''

baseBranchPath=$(git branch -r | grep $basebranch)
secondaryBranchPath=$(git branch -r | grep $secondarybranch)

commitDiffCount=$(echo $(git log --oneline $secondaryBranchPath ^$baseBranchPath | wc -l))

echo '{"commitDiffCount": "'$commitDiffCount'"}' 
