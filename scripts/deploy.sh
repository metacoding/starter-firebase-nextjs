#! /usr/bin/env bash

set -e

[[ $FB_ENV == 'production' ]] && \
    PROJECT="$STATIC_PROD_PROJECT" || \
    PROJECT="$STATIC_STAGE_PROJECT"

if [ -z "$PROJECT" ]; then
    echo "$FB_ENV environment not setup, try 'yarn setup' first"
    exit 1
fi

yarn build:clean
yarn firebase deploy \
    --only functions,hosting,firestore:rules \
    --project $PROJECT \
    --token $STATIC_DEPLOY_KEY
