#!/bin/bash
set -eoux pipefail

baseBranch=$1
secondaryBranch=$2

commitDiffCount=''

baseBranch=$(git branch -r | grep $basebranch)
secondaryBranch=$(git branch -r | grep $secondarybranch)

commitDiffCount=$(echo $(git log --oneline $secondaryBranch ^$baseBranch | wc -l))

echo '{"commitDiffCount": "'$commitDiffCount'"}' 
