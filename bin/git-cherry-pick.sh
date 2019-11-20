#!/usr/bin/env bash

# Written by Vagelis Prokopiou <vagelis.prokopiou@gmail.com>

myBranchesPrefix="vp_";

if [[ ! $1 ]]; then
    echo "Usage: git-cherry-pick <commitHash>";
    exit 1;
fi

commit="$1";
currentBranch=$(git status | head -n 1 | awk '{ print $3 }');

git branch --all | grep remotes | grep -v $currentBranch |  grep -v HEAD | grep $myBranchesPrefix | sed 's|remotes/origin/||g' | while read branch; do
    git checkout "${branch}";
    git pull;
    git cherry-pick "${commit}";
    git push;    
done;

# Allowing for any branch handling, when explicitly applied. Todo: Add documentation.
if [[ $2 ]]; then
    git checkout "${2}";
    git pull;
    git cherry-pick "${commit}";
    git push;    
fi

git checkout "${currentBranch}";