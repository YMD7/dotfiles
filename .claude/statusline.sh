#!/usr/bin/env bash
input=$(cat)

# ANSI colors (inspired by Starship palette)
BLUE='\033[38;2;118;159;240m'    # #769ff0 — directory / branch
LAVENDER='\033[38;2;160;169;203m' # #a0a9cb — model name
MUTED='\033[38;2;100;116;139m'   # slate   — context gauge
RESET='\033[0m'

# Icons
ICON_BRANCH=$'\uf418'  # Octicons git-branch

# Model info
MODEL=$(echo "$input" | jq -r '.model.display_name')

# Directory (./{basename} format)
CWD=$(echo "$input" | jq -r '.workspace.current_dir')
DIR_NAME="./"$(basename "$CWD")

# Git branch
GIT_BRANCH=$(git --git-dir="$CWD/.git" --work-tree="$CWD" rev-parse --abbrev-ref HEAD 2>/dev/null)

# Context usage
USED_PCT=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$USED_PCT" ]; then
  USED_INT=$(printf "%.0f" "$USED_PCT")
  CTX_STR="${USED_INT}%"
else
  CTX_STR="0%"
fi

# Compose status line
if [ -n "$GIT_BRANCH" ]; then
  printf "${LAVENDER} 󰉋 %s${RESET}  ${LAVENDER}${ICON_BRANCH} %s${RESET}  ${MUTED} 󰚩 %s${RESET}  ${BLUE}󰒆 %s${RESET}" \
    "$DIR_NAME" "$GIT_BRANCH" "$MODEL" "$CTX_STR"
else
  printf "${LAVENDER} 󰉋 %s${RESET}  ${MUTED} 󰚩 %s${RESET}  ${BLUE}󰒆 %s${RESET}" \
    "$DIR_NAME" "$MODEL" "$CTX_STR"
fi

