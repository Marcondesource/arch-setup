#!/usr/bin/env bash

MAX_CHARS=20
ICON=""

CLIP_CONTENT=$(xclip -o -selection clipboard 2>/dev/null | head -c $MAX_CHARS)
CLIP_LENGTH=$(echo -n "$CLIP_CONTENT" | wc -m)

if [ "$CLIP_LENGTH" -gt 0 ]; then
    if [ "$CLIP_LENGTH" -ge "$MAX_CHARS" ]; then
        ELLIPSIS="..."
    else
        ELLIPSIS=""
    fi
    echo "$ICON ${CLIP_CONTENT}${ELLIPSIS}"
else
    echo ""
fi
