#!/bin/bash
set -eou pipefail

baseBranch=$1
secondaryBranch=$2

commitDiffCount=''

commitDiffCount=$(git log --oneline $scondaryBranch ^$baseBranch | wc -l)

echo '{"commitDiffCount": "'$commitDiffCount'"}' 
