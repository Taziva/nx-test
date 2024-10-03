#!/bin/bash

# Access parameters
APP=$1

# Your logic here
if [[ "$VERCEL_ENV" == "production" ]]; then
  npx nx-ignore $APP
  exit $? # Exit with the same status as NX Ignore
else
  BRANCH_NAME=$VERCEL_GIT_COMMIT_REF

  if [[ "$BRANCH_NAME" == "main" || "$BRANCH_NAME" == "staging" ]]; then
    npx nx-ignore $APP
    exit $? # Exit with the same status as NX Ignore
  else
    echo "Build cancelled for branch $BRANCH_NAME"
    exit 0
  fi
fi