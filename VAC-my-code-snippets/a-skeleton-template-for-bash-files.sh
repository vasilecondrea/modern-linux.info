#!/usr/bin/env bash
set -o errexit # we want to stop the script execution if an error happens.
set -o nounset # we treat unset variables as an error
set -o pipefail # when one part of a pipe fails, the whole pipe should be considered failed

firstargument="${1:-thisSintaxwith1:setsAdefaultValueWhichFallowsAfter:}"
echo "$firstargument"
