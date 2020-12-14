#!/usr/bin/env bash

set -e

# macOS: brew install libxml2 upx launch4j

cd .

for XML in *.xml; do
  echo "${XML}"
  launch4j "${XML}"
  EXE=$(xmllint --xpath '//outfile/text()' "${XML}")
  upx --ultra-brute "${EXE}"
done
