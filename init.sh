#!/bin/bash
if [[ -z "${ALLOWED_PEERS}" ]]; then
  echo "ALLOWED_PEERS is not set"
  exit 1
fi

if [[ -z "${IDENTITY_BASE64}" ]]; then
  echo "IDENTITY_BASE64 is not set"
  exit 1
fi

echo "${ALLOWED_PEERS}" | jq -R '{RelayV2:{Resources:{Limit:null}},ACL:{AllowPeers:split(",")}}' > /app/config.json
echo "${IDENTITY_BASE64}" | base64 -d > /app/identity.key
