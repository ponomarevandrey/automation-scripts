#!/bin/bash

# DESCRIPTION
#     Backup and compress Postgres database running in Docker container
#
# SYNTAX
#     <Docker database container ID> 
#
#     - example: ./script 1cf19598f5a5


set -eu



DOCKER_DB_CONTAINER_ID="$1"
DB_USERNAME="postgres"

docker exec --tty "$DOCKER_DB_CONTAINER_ID" \
  pg_dumpall --clean -U "$DB_USERNAME" | \
    gzip > \
      /var/data/postgres/backups/dump_date +%d-%m-%Y"_"%H_%M_%S.gz 
