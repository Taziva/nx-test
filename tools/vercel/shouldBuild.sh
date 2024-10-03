#!/bin/bash

# Access parameters
APP=$1

# Your logic here
if [[ "$VERCEL_ENV" == "production" ]]; then
  npx nx-ignore $APP
  exit $? # Exit with the same status as NX Ignore
else
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
  if [[ "$BRANCH_NAME" == "main" ]]; then
    npx nx-ignore $APP
    exit $? # Exit with the same status as NX Ignore
  else
    echo "Build cancelled for branch $BRANCH_NAME"
    exit 0
  fi
fi