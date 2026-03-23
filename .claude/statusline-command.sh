#!/bin/sh
input=$(cat)

remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
total=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
used_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty')

if [ -n "$remaining" ] && [ -n "$total" ] && [ -n "$used_tokens" ]; then
  remaining_tokens=$(echo "$total $used_tokens" | awk '{printf "%d", $1 - $2}')
  printf "\033[36mCtx left:\033[0m %.0f%% (%s tokens)" "$remaining" "$remaining_tokens"
elif [ -n "$remaining" ]; then
  printf "\033[36mCtx left:\033[0m %.0f%%" "$remaining"
else
  printf "\033[36mCtx left:\033[0m no data yet"
fi
