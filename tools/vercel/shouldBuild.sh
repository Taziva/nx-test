#!/bin/bash

# Access parameters
APP=$1

# Your logic here
if [[ "$VERCEL_ENV" == "production" ]]; then
  npx nx-ignore $APP
  exit $? # Exit with the same status as NX Ignore
else
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
  SHOW_CURRENT_BRANCH=$(git branch --show-current)
  SYMBOLIC_REF=$(git symbolic-ref --short HEAD)

  echo
  echo "**** Running post-commit hook from branch $BRANCH_NAME"
  echo
  echo "**** Running post-commit symbolic-ref hook from branch $SYMBOLIC_REF"
  echo
  echo "**** Running post-commit current hook from branch $SHOW_CURRENT_BRANCH"
  echo

  if [[ "$BRANCH_NAME" == "main" ]]; then
    npx nx-ignore $APP
    exit $? # Exit with the same status as NX Ignore
  else
    echo "Build cancelled for branch $BRANCH_NAME"
    exit 0
  fi
fi