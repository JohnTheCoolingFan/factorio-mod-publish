#!/bin/bash

if [[ -v INFO_JSON_FILE ]]; then
    export MOD_NAME="$(jq -r .name $INFO_JSON_FILE)"
    if [[ ! -v MOD_FILE ]]; then
        export MOD_FILE=$(jq -r '.name + "_" + .version + ".zip"' $INFO_JSON_FILE)
    fi
fi

if [[ ! -v MOD_NAME ]]; then
    echo "MOD_NAME is not set"
    exit 1
fi

if [[ ! -v MOD_FILE ]] || [[ -z MOD_FILE ]]; then
    echo "MOD_FILE is not set"
    exit 1
fi

UPLOAD_URL=$(curl -X POST -d mod="${MOD_NAME}" -H "Authorization: Bearer ${FACTORIO_PORTAL_TOKEN}"  https://mods.factorio.com/api/v2/mods/releases/init_upload | jq -r ".upload_url")

curl -X POST -s -F "file=${MOD_FILE}" "${UPLOAD_URL}"
