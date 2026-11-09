#!/usr/bin/env bash

if [[ $# -ne 1 || -z "$1" ]]; then
    echo "Использование: $0 URL" >&2
    exit 1
fi

if code=$(curl -q -sS -o /dev/null -w '%{http_code}' --max-time 10 --proto '=http,https' -- "$1") &&
    [[ "$code" == 200 ]]; then
    echo 'API доступен'
    exit 0
fi

echo "API недоступен, код ответа: ${code:-000}"
exit 1
