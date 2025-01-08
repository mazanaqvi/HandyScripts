#!/bin/bash

# Colors for messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Assign the first argument as the commit message, if provided
COMMIT_MESSAGE=$1

# Function to handle errors
handle_error() {
  echo -e "${RED}mazanaqvi: An error occurred. Exiting.${NC}"
  exit 1
}

# Check if there are changes to commit
if git diff-index --quiet HEAD --; then
  echo -e "${YELLOW}No changes to commit. Proceeding with deployment...${NC}"
else
  # Check if a commit message was provided
  if [ -n "$COMMIT_MESSAGE" ]; then
    # Add all changes to git
    echo -e "${BLUE}Adding all changes to git...${NC}"
    git add . || handle_error
    echo -e "${GREEN}All changes added to git.${NC}"

    # Commit the changes with the provided message
    echo -e "${BLUE}Committing changes with message: ${YELLOW}$COMMIT_MESSAGE${NC}"
    git commit -m "$COMMIT_MESSAGE" || handle_error
    echo -e "${GREEN}Changes committed successfully.${NC}"

    # Push the changes to the remote repository
    echo -e "${BLUE}Pushing changes to the remote repository...${NC}"
    git push || handle_error
    echo -e "${YELLOW}Changes pushed successfully.${NC}"
  else
    echo -e "${YELLOW}Commit message not provided. Skipping git commit and push steps.${NC}"
  fi
fi

# Build the Flutter web project in release mode
echo -e "${BLUE}Building Flutter web project in release mode...${NC}"
flutter build web --release || handle_error
echo -e "${YELLOW}Flutter web project built successfully.${NC}"

# Deploy to Firebase
echo -e "${BLUE}Deploying to Firebase...${NC}"
firebase deploy || handle_error
echo -e "${YELLOW}Deployment to Firebase complete.${NC}"

# Print a success message
echo -e "${GREEN}Hi mazanaqvi, your deployment is complete. ;)${NC}"
