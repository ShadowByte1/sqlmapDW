#!/bin/bash

# URL to send the alert to
webhook_url="Webhook Here"

# URL to send in the alert
url=$1

# Message to send
message="SQLi FOUND!\nURL: $url"

# Create JSON payload
payload="{\"content\": \"$message\"}"

# Send POST request to Discord webhook
curl -H "Content-Type: application/json" -X POST -d "$payload" "$webhook_url"
