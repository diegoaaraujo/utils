#!/usr/bin/env bash

set -euo pipefail

if [ -z ${1+x} ]; then
    echo "Specify Elasticsearch endpoint as argument!"
    exit
fi

ENDPOINT="$1"
PAYLOAD='{"mappings": {"_default_": {"dynamic_templates": [{"strings": {"mapping": {"index": "not_analyzed","type": "string"}, "match_mapping_type": "string"}}]}}, "template": "*"}'

# Disable analyzing indices (tokenization).
echo "Disabling tokenization..."
curl -X PUT -d "${PAYLOAD}" "${ENDPOINT}/_template/global"

echo -e "\nPurging existing data for reindexing..."
# Purge data to reindex without tokenization.
curl -X DELETE "${ENDPOINT}/_all"

echo -e "\nDone!"
