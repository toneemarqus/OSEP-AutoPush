#!/bin/bash

# Define the directory containing the cloned repository
DIRECTORY="/var/www/html"

# Change to the specified directory
cd "$DIRECTORY" || { echo "Directory not found"; exit 1; }

# Fetch the latest changes from the remote
git fetch origin

# Check if there are differences between the local and remote repositories
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})

# Check for untracked files
UNTRACKED=$(git ls-files --others --exclude-standard)

# Check for modified or deleted files
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
    
    # Add all changes (including untracked and deleted files) to the staging area
    git add -A
    
    # Check the status to ensure files are staged
    echo "Staged files:"
    git status

    # Commit the changes with a message
    git commit -m "Auto-commit: Adding untracked and modified files"
    
    # Set LOCAL to the latest commit after adding new files
    LOCAL=$(git rev-parse @)
else
    echo "No changes detected."
fi

# Debugging output
echo "LOCAL commit: $LOCAL"
echo "REMOTE commit: $REMOTE"

# If local and remote repositories differ
if [ "$LOCAL" != "$REMOTE" ]; then
    echo "Local repository differs from the remote, pushing changes..."

    # Push the changes to the remote repository
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
