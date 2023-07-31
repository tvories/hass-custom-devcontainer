#!/bin/bash

function ensure_hass_config() {
    hass --script ensure_config -c /config
}

function create_hass_user() {
    local username=${HASS_USERNAME:-dev}
    local password=${HASS_PASSWORD:-dev}
    echo "Creating Home Assistant User ${username}:${password}"
    hass --script auth -c /config add ${username} ${password}
}

function bypass_onboarding() {
    cat > /config/.storage/onboarding << EOF
{
    "data": {
        "done": [
            "user",
            "core_config",
            "integration"
        ]
    },
    "key": "onboarding",
    "version": 3
}
EOF
}

function setup() {
    ensure_hass_config
    create_hass_user
    bypass_onboarding
}

function run() {
    hass -c /config -v
}

if [[ -f "$ENV_FILE" ]]; then
    source "$ENV_FILE"
fi

setup
run
