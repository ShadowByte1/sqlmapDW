#!/bin/bash

# Discord webhook URL
webhook_url="Webhook Here"

# Function to send alert to Discord
send_alert() {
  local url=$1
  local message="SQLi FOUND!\nURL: $url"
  local payload="{\"content\": \"$message\"}"
  curl -H "Content-Type: application/json" -X POST -d "$payload" "$webhook_url"
}

# Check if -f or -u option is provided
if [ "$1" == "-f" ]; then
  file=$2
  shift 2
  while IFS= read -r url; do
    echo "Testing URL: $url"
    sqlmap -u "$url" "$@" --batch --hostname --alert="./webhook.sh '$url'"
  done < "$file"
elif [ "$1" == "-u" ]; then
  url=$2
  shift 2
  echo "Testing URL: $url"
  sqlmap -u "$url" "$@" --batch --hostname --alert="./webhook.sh '$url'"
else
  echo "Usage: $0 -f <file> [options] | -u <url> [options]"
  exit 1
fi
