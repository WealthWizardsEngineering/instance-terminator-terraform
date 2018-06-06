#!/bin/bash

set -e

function error_exit() {
  echo "$1" 1>&2
  exit 1
}

function check_deps() {
  test -f $(which curl) || error_exit "curl command not detected in path, please install it"
  test -f $(which jq) || error_exit "jq command not detected in path, please install it"
}

function validate_input() {
    # jq reads from stdin so we don't have to set up any inputs, but let's validate the outputs
    eval "$(jq -r '@sh "URL=\(.url) OUTPUT_DIRECTORY=\(.output_directory) OUTPUT_FILENAME=\(.output_filename)"')"
    if [ "${URL}" == "null" ]; then error_exit "url is a required parameter"; fi
    if [ "${OUTPUT_DIRECTORY}" == "null" ]; then export OUTPUT_DIRECTORY=.; fi
    if [ "${OUTPUT_FILENAME}" == "null" ]; then export OUTPUT_FILENAME=output_file; fi
    export OUTPUT_FILE=${OUTPUT_DIRECTORY}/${OUTPUT_FILENAME}
}

function download_file() {
  curl --location --silent --output ${OUTPUT_FILE} ${URL}
}

function produce_output() {
  jq -n \
    --arg result "success" \
    --arg output_file "${OUTPUT_FILE}" \
    '{"result":$result, "output_file": $output_file}'
}

# main()
check_deps
validate_input
download_file
produce_output