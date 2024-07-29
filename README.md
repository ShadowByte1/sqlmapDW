# sqlmapDW
sqlmap Discord Webhook Addition


# SQLMap Automation and Alert System

This project automates SQL injection testing using SQLMap and sends alerts to a Discord webhook when a vulnerability is detected. It supports testing individual URLs as well as multiple URLs from a file.

## Setup

### Prerequisites

- [SQLMap](https://github.com/sqlmapproject/sqlmap) installed on your system.
- `curl` installed for sending HTTP requests to Discord.
- Bash shell for running the provided scripts.

### Configuration

1. **Set Up Your Discord Webhook**

   Replace `YOUR_WEBHOOK_URL` in the `webhook.sh` and `sqlmap.sh` script with your actual Discord webhook URL. You can find this URL in your Discord server settings.

2. **Update bash File Scripts**

   Edit the `webhook.sh` file to include your Discord webhook URL:
   Edit the `sqlmap.sh`  file to include your Discord webhook URL:
   
   # Replace with your actual Discord webhook URL
   WEBHOOK_URL="WEBHOOK Here"
   
# Set Up Your SQLMap Automation Script

Ensure sqlmap.sh and webhook.sh is executable using chmod +x sqlmap.sh / webhook.sh 

# Usage
Testing a Single URL
To test a single URL and receive alerts, use the following command:


./sqlmap.sh -u "http://example.com/vuln.php?id=1" --dbs --batch --hostname --alert="./webhook.sh \$\$"
This command runs SQLMap on the specified URL, and if a vulnerability is detected, the webhook.sh script will send an alert to your Discord webhook with the URL being tested.

# Testing Multiple URLs from a File
To test multiple URLs from a file, ensure your urls.txt file has one URL per line:

Run SQLMap with the following command:

./sqlmap.sh -f urls.txt --dbs --level=3 --risk=3 --alert="./webhook.sh \$\$"
This command will iterate through each URL in the urls.txt file and run SQLMap on each one. Alerts will be sent to your Discord webhook for each detected vulnerability.

Notes
Make sure that webhook.sh has execution permissions. You can set this with chmod +x webhook.sh.
Ensure that sqlmap.sh has execution permissions. You can set this with chmod +x sqlmap.sh.
Adjust the SQLMap options according to your needs. Refer to SQLMap's documentation for more details on available options.
