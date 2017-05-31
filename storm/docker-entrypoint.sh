#!/bin/bash

set -e

if [ "$1" = 'nimbus' ]; then
  exec storm nimbus
elif [ "$1" = 'supervisor' ]; then
  exec storm supervisor
elif [ "$1" = 'ui' ]; then
  exec storm ui
fi

exec "$@"