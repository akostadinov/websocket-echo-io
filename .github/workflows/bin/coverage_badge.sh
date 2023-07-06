#!/bin/env bash

result=coverage/.last_run.json
badge=coverage/badge.png

# TODO use jq if present in github runner
percent=$(ruby -rjson -e "puts JSON.load(File.read('coverage/.last_run.json'))['result']['line'].floor")

if [[ "$percent" = 9[0-9] ]] || [[ "$percent" = 100* ]]; then
  color=green
elif [[ "$percent" = [6-8]? ]]; then
  color=orange
else
  color=red
fi

curl "https://img.shields.io/badge/coverage-$percent%25-$color" > coverage/badge.svg
