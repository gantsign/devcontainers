#!/usr/bin/env bash

while ! (docker ps > /dev/null 2>&1); do
    echo 'Waiting for Docker...'
    sleep 1
done

echo 'Starting k3s...'

( k3s server --docker > /var/log/k3s.log 2>&1 ) &

# Execute whatever commands were passed in (if any). This allows us
# to set this script to ENTRYPOINT while still executing the default CMD.
exec "$@"
