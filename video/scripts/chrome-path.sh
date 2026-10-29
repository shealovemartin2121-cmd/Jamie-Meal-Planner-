#!/usr/bin/env bash
# Print the Chrome Headless Shell that `hyperframes browser ensure` downloaded.
ls -d "${HOME}"/.cache/hyperframes/chrome/chrome-headless-shell/*/chrome-headless-shell-*/chrome-headless-shell 2>/dev/null | sort | tail -1
