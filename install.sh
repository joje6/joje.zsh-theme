#!/usr/bin/env sh

set -e

_ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

SRC_URL="https://github.com/joje6/joje.zsh-theme.git"
DST_DIR="${ZSH_CUSTOM:-${_ZSH_CUSTOM}}/themes/joje"

mkdir -p `dirname ${DST_DIR}`

if [ -d "${DST_DIR}" ]; then
    if [ -d "${DST_DIR}/.git" ]; then
        (cd ${DST_DIR} && git pull --ff-only origin master)
    fi
else
    git clone ${SRC_URL} ${DST_DIR}
fi

ln -sf ${DST_DIR}/*.zsh-theme ${ZSH_CUSTOM:-${_ZSH_CUSTOM}}/themes