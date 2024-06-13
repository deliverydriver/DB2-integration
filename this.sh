#!/bin/bash

# Set variables
DB2_ENDPOINT="https://****.com/api/data"
GIT_REPO_PATH="/Users/macbookair/VC/DB2-integration"
COMMIT_MESSAGE_PREFIX="Initial Commit "

# Loop for 20 commits
for ((i = 1; i <= 20; i++)); do
    # Touch a file
    touch "file_$i.txt"

     curl -X GET $DB2_ENDPOINT

    # Add changes to Git
    git -C $GIT_REPO_PATH add .

    # Commit changes
    git -C $GIT_REPO_PATH commit -m "$COMMIT_MESSAGE_PREFIX$i"

    # Sleep for a while before the next commit (optional)
    sleep 1
done

