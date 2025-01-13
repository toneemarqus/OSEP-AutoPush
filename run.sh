#!/bin/bash


DIRECTORY="/var/www/html"


cd "$DIRECTORY" || { echo "Directory not found"; exit 1; }


git fetch origin

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})


UNTRACKED=$(git ls-files --others --exclude-standard)


CHANGES=$(git status --porcelain)

if [[ -n "$UNTRACKED" || -n "$CHANGES" ]]; then
    if [[ -n "$UNTRACKED" ]]; then
        echo "There are untracked files:"
        echo "$UNTRACKED"
    fi

    if [[ -n "$CHANGES" ]]; then
        echo "There are changes to be committed (modified/deleted files):"
        echo "$CHANGES"
    fi
    

    git add -A
    

    echo "Staged files:"
    git status


    git commit -m "Auto-commit: Adding untracked and modified files"
    

    LOCAL=$(git rev-parse @)
else
    echo "No changes detected."
fi


echo "LOCAL commit: $LOCAL"
echo "REMOTE commit: $REMOTE"


if [ "$LOCAL" != "$REMOTE" ]; then
    echo "Local repository differs from the remote, pushing changes..."


    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    if git push origin "$CURRENT_BRANCH"; then
        echo "Changes pushed to remote repository."
    else
        echo "Failed to push changes to remote repository."
        exit 1
    fi
else
    echo "Local repository is up-to-date with the remote. No changes to push."
fi
