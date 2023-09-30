#!/usr/bin/env bash

# It is expected that this script is run from the root of the `backend-elixir` project.

# set up an exit on error
set -o errexit

# install dependencies
mix deps.get --only prod

# compile for production
MIX_ENV=prod mix compile

# complie the JavaScript and CSS assets
MIX_ENV=prod mix assets.deploy

# build the release
MIX_ENV=prod mix release --overwrite
