#!/bin/bash

export MOD_NAME="$(jq -r .name $INFO_JSON_FILE)"
export MOD_FILE=$(jq -r '.name + "_" + .version + ".zip"' $INFO_JSON_FILE)

UPLOAD_URL=$(curl -X POST -d mod="${MOD_NAME}" -H "Authorization: Bearer ${FACTORIO_PORTAL_TOKEN}"  https://mods.factorio.com/api/v2/mods/releases/init_upload | jq -r ".upload_url")

curl -X POST -s -F "file=${MOD_FILE}" "${UPLOAD_URL}"
