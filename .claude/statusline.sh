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

# Directory (/{dirname} format)
CWD=$(echo "$input" | jq -r '.workspace.current_dir')
DIR_NAME="/"$(basename "$CWD")

# Git branch
GIT_BRANCH=$(git --git-dir="$CWD/.git" --work-tree="$CWD" rev-parse --abbrev-ref HEAD 2>/dev/null)

# Git status indicators
GIT_STATUS=""
if [ -n "$GIT_BRANCH" ]; then
  GIT_RAW=$(git --git-dir="$CWD/.git" --work-tree="$CWD" status --porcelain -b 2>/dev/null)
  # Ahead/behind
  AHEAD=$(echo "$GIT_RAW" | head -1 | sed -n 's/.*ahead \([0-9]*\).*/\1/p')
  BEHIND=$(echo "$GIT_RAW" | head -1 | sed -n 's/.*behind \([0-9]*\).*/\1/p')
  # Staged / unstaged / untracked (skip first line which is branch info)
  STAGED=$(echo "$GIT_RAW" | tail -n +2 | grep -c '^[MADRC]')
  UNSTAGED=$(echo "$GIT_RAW" | tail -n +2 | grep -c '^.[MDRC]')
  UNTRACKED=$(echo "$GIT_RAW" | tail -n +2 | grep -c '^??')
  [ "$STAGED" -gt 0 ] 2>/dev/null && GIT_STATUS="${GIT_STATUS}●"
  [ "$UNSTAGED" -gt 0 ] 2>/dev/null && GIT_STATUS="${GIT_STATUS}✚"
  [ "$UNTRACKED" -gt 0 ] 2>/dev/null && GIT_STATUS="${GIT_STATUS}…"
  [ "$AHEAD" -gt 0 ] 2>/dev/null && GIT_STATUS="${GIT_STATUS}⇡"
  [ "$BEHIND" -gt 0 ] 2>/dev/null && GIT_STATUS="${GIT_STATUS}⇣"
fi

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
  GIT_DISPLAY="${GIT_BRANCH}"
  [ -n "$GIT_STATUS" ] && GIT_DISPLAY="${GIT_BRANCH}(${GIT_STATUS})"
  printf "${BLUE}󰒆 %s${RESET}  ${LAVENDER} 󰉋 %s${RESET}  ${LAVENDER}${ICON_BRANCH} %s${RESET}  ${MUTED} 󰚩 %s${RESET}" \
    "$CTX_STR" "$DIR_NAME" "$GIT_DISPLAY" "$MODEL"
else
  printf "${BLUE}󰒆 %s${RESET}  ${LAVENDER} 󰉋 %s${RESET}  ${MUTED} 󰚩 %s${RESET}" \
    "$CTX_STR" "$DIR_NAME" "$MODEL"
fi

