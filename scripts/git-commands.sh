# Utility functions for git

function gitrmbranch {
    git branch -D $1
    git push --delete origin $1
}
compdef __git_branch_names gitrmbranch

function gitnewbranch {
    git checkout -b $1
    git push -u origin HEAD
}
compdef __git_branch_names gitnewbranch
