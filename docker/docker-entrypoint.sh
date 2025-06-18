#!/bin/sh
set -e
set -x

if [ "$1" = 'php-fpm' ] || [ "$1" = 'bin/console' ]; then
  if [ ! -f composer.json ]; then
    rm -Rf tmp/
    symfony new tmp --version="$SYMFONY_VERSION" --no-git --webapp
    cd tmp
    cp -Rp . ..
    cd -
    rm -Rf tmp/
  fi

  # Display information about the current project
  # Or about an error in project initialization
  php bin/console -V
fi

exec "$@"
