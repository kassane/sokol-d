#! /usr/bin/env bash

# see all params
# ZIG_VERBOSE_CC=1

ARGS=()
for arg in "$@"; do
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ $arg == "-target" ]]; then
        ARGS=("${ARGS[@]/$arg}")
    fi
  fi
  if [[ $arg == "x86_64-apple-macos" ]]
  then
    ARGS=("${ARGS[@]/$arg}")
  elif [[ $args == "aarch64-apple-macos" ]]
  then
    ARGS=("${ARGS[@]/$arg}") 
  else
    ARGS+=("$arg")
  fi
done

zig cc -lunwind "${ARGS[@]}"