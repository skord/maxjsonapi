#!/bin/bash
set -e

# Figure out where this script is located.
SELFDIR="`dirname \"$0\"`"
SELFDIR="`cd \"$SELFDIR\" && pwd`"

# Tell Bundler where the Gemfile and gems are.
export BUNDLE_GEMFILE="$SELFDIR/lib/vendor/Gemfile"
export SECRET_KEY_BASE="c9aaf8546492f065c725cfa523424cf5da90d404d214404862ed939345efb8386d4faebe3aa3d85259746978d2c793f98d0c2b33a91d05c77959c36e8be318d7"
export RAILS_LOG_TO_STDOUT='true'
unset BUNDLE_IGNORE_CONFIG

for i in "$@"
do
case $i in
  -h=*|--host=*)
  MAXSCALE_MAXINFO_IP_PORT="$i#*="
  shift
  ;;

esac
done

if [ -z "$MAXSCALE_MAXINFO_IP_PORT" ]; then
  echo >&2 'error: you must set --host= to reflect your maxinfo IP and TCP port or set the environmental variable MAXSCALE_MAXINFO_IP_PORT=ip:port. example: --host=10.190.0.3:8003 || export MAXSCALE_MAXINFO_IP_PORT=10.190.0.3:8003'
  exit 1
fi

# Run the actual app using the bundled Ruby interpreter.
exec "$SELFDIR/lib/ruby/bin/ruby" "$SELFDIR/lib/app/bin/rails" "s" "-p" "9292" "-b" "0.0.0.0"
