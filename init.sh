#!/bin/bash
if [[ -z "${ALLOWED_PEERS}" ]]; then
  echo "ALLOWED_PEERS is not set"
  exit 1
fi

if [[ -z "${IDENTITY_BASE64}" ]]; then
  echo "IDENTITY_BASE64 is not set"
  exit 1
fi

echo "{\"peers\":\"${ALLOWED_PEERS}\",\"announce\":\"${ANNOUNCE_ADDRS}\"}" | jq "{Network:{AnnounceAddrs:.announce|split(\",\")},RelayV2:{Resources:{Limit:null,MaxReservations:${MAX_RESERVATIONS:-1280},MaxCircuits:${MAX_CIRCUITS:-160},MaxReservationsPerPeer:${MAX_RESERVATIONS_PER_PEER:-40},MaxReservationsPerIP:${MAX_RESERVATIONS_PER_IP:-80},MaxReservationsPerASN:${MAX_RESERVATIONS_PER_ASN:-320}}},ACL:{AllowPeers:.peers|split(\",\")}}" > /app/config.json
echo "${IDENTITY_BASE64}" | base64 -d > /app/identity.key
