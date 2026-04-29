#!/usr/bin/env bash

set -euo pipefail

STACK_VERSION="${1:?'Error: The stack version number must be specified as the first argument.'}"

set -x

docker build --progress=plain --build-arg="STACK_VERSION=${STACK_VERSION}" -t heroku-buildpack-minizinc .

# Note: All of the container commands must be run via a login bash shell otherwise the profile.d scripts won't be run.

# Check the profile.d scripts correctly added the binaries to PATH.
docker run --rm heroku-buildpack-minizinc bash -l -c 'minizinc --version'