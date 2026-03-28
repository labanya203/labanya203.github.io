#!/usr/bin/env bash
# Pre-commit script for staticrypt and committing encrypted files
# Usage: ./precommit.sh [optional commit message]

# Set PowerShell execution policy for the process
#pwsh -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process"
echo "Running staticrypt and preparing commit..."
# Run staticrypt to encrypt index.html and plots directory
npx staticrypt ./src/index.html ./src/plots/ -r --directory docs
echo "Staticrypt completed. Adding changes to git staging..."

# Add all changed files (not in .gitignore) to git staging
git add -u
git add .

# Prepare commit message
DATE=$(date +"%Y-%m-%d")
COMMIT_MSG="$DATE"
if [ -n "$1" ]; then
    COMMIT_MSG="$COMMIT_MSG $1"
else
    COMMIT_MSG="$COMMIT_MSG Update encrypted files"
fi

# Commit and push
git commit -m "$COMMIT_MSG"
git push

echo "Staticrypt run, encrypted files committed and pushed with message: $COMMIT_MSG"