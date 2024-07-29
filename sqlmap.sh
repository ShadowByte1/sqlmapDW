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

# Function to process URLs
process_urls() {
  while IFS= read -r url; do
    echo "Testing URL: $url"
    sqlmap -u "$url" "$@" --batch --hostname --alert="./webhook.sh '$url'"
  done
}

# Check if -f or -u option is provided
if [ "$1" == "-f" ]; then
  file=$2
  shift 2
  if [ -f "$file" ]; then
    cat "$file" | process_urls
  else
    echo "File not found: $file"
    exit 1
  fi
elif [ "$1" == "-u" ]; then
  url=$2
  shift 2
  echo "Testing URL: $url"
  sqlmap -u "$url" "$@" --batch --hostname --alert="./webhook.sh '$url'"
elif [ -t 0 ]; then
  echo "Usage: $0 -f <file> [options] | -u <url> [options] | <urls from stdin>"
  exit 1
else
  process_urls "$@"
fi
