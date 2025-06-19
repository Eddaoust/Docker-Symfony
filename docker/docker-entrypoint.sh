#!/bin/sh
set -e
set -x

if [ "$1" = 'php-fpm' ] || [ "$1" = 'bin/console' ]; then
  if [ ! -f composer.json ]; then
    echo "========================================================================="
    echo "             🚀 Starting new Symfony project installation... 🚀"
    echo "========================================================================="

    rm -Rf tmp/
    symfony new tmp --version="$SYMFONY_VERSION" --no-git --webapp
    cd tmp
    rm compose.yaml
    rm compose.override.yaml
    cp -Rp . ..
    cd -
    rm -Rf tmp/
    echo "========================================================================="
    echo "        ✅ Symfony project installed successfully! ✅"
    echo ""
    echo "        You can access your application at http://localhost:8080"
    echo "        You can access Maildev at http://localhost:8383"
    echo "========================================================================="

  fi

  # Display information about the current project
  # Or about an error in project initialization
  php bin/console -V
fi

exec "$@"
