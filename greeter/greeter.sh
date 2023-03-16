#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail

name="${1}"
# [] - this is a test expression
# tests: -z if the length of string (input) is zero, print "you are awsome", else say "hello name...."
if [ -z "$name" ]
then
  printf "You are awsome!\n"
else
  printf "Hello %s, you are awesome!\n" ${name}
fi