#!/usr/bin/env bash
# Pre-commit script for staticrypt and committing encrypted files
# Usage: ./precommit.sh [optional commit message]

# Spninner animation
spinner() {
    local i sp n
    sp='/-\\|\'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\\b" "${sp:i++%n:1}"
    done
}


# Set PowerShell execution policy for the process
#pwsh -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process"
# echo "Setting PowerShell execution policy to RemoteSigned for the current user:"
# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# Run staticrypt to encrypt index.html and plots directory
printf 'Encrypting files with staticrypt... '
spinner &  # Run the spinner function in the background
SPIN_PID=$! # Capture the process ID of the spinner
npx staticrypt ./src/index.html ./src/plots/ -r --directory docs --verbose
kill "$SPIN_PID" # Kill the spinner process
printf '\n' # Move to a new line after the spinner stops

# Add all changed files (not in .gitignore) to git staging
git -c advice.all=false add .

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