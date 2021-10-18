#!/bin/bash
readonly COOKIE_FILE='./cookies.txt'
function get_ids {
  for file in $(ls training-*.json)
  do
    IFS='-' read -r -a _tr <<< "$file"
    echo "${_tr[5]}"
  done
}

function main {
  mkdir data
  for _id in $(get_ids)
  do
    curl -L -b "${COOKIE_FILE}" "https://flow.polar.com/api/export/training/gpx/${_id}" -o data/"${_id}.gpx" > /dev/null 2>&1
  done
  for file in $(ls -lah data/ | grep -v 'k' | awk '{print $7}');
  do
    rm $file;
  done
}

main
