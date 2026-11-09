#!/usr/bin/env bash
set -euo pipefail

log=access.log

{
    for i in {1..150}; do
        echo '192.168.1.10 - - [15/Aug/2026:10:15:32] "GET /api/users HTTP/1.1" 200'
    done
    for i in {1..90}; do
        echo '10.0.0.5 - - [15/Aug/2026:10:15:33] "POST /api/login HTTP/1.1" 401'
    done
    for i in {1..60}; do
        echo '192.168.1.20 - - [15/Aug/2026:10:15:34] "GET /api/users HTTP/1.1" 503'
    done
} > "$log"

echo "Total requests: $(awk 'END { print NR }' "$log")"
echo 'Top 3 IP addresses:'
grep -oE '^([0-9]{1,3}\.){3}[0-9]{1,3}' "$log" | sort | uniq -c | sort -nr | head -n 3
awk '
    $NF ~ /^4[0-9][0-9]$/ { client_errors++ }
    $NF ~ /^5[0-9][0-9]$/ { server_errors++ }
    END {
        printf "4xx requests: %d\n", client_errors
        printf "5xx requests: %d\n", server_errors
    }
' "$log"
