#!/usr/bin/env sh
set -e

if [ "$1" ]; then
    #chown -R postgres "$PGDATA"
    #if [ -z "$(ls -A "$PGDATA")" ]; then
    #    gosu postgres initdb
    #fi

    exec java -jar ,"-Djava.security.egd=file:/dev/./urandom" "-Djava.io.tmpdir=$TMPDIR" "$JETTY_HOME/start.jar" "$@"
fi

exec "$@"
