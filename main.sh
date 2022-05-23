#!/usr/bin/env bash
set -e
set -x

[ -z "$N8N_ENCRYPTION_KEY" ] && echo "N8N_ENCRYPTION_KEY not configured" && exit 1
[ -z "$PORT" ] && export PORT=8080
[ -z "$N8N_PORT" ] && export N8N_PORT=$PORT
[ -z "$N8N_PROTOCOL" ] && export N8N_PROTOCOL=https

# Database
export DB_TYPE=postgresdb
export DB_POSTGRESDB_DATABASE=$POSTGRESQL_ADDON_DB
export DB_POSTGRESDB_HOST=$POSTGRESQL_ADDON_HOST
export DB_POSTGRESDB_PORT=$POSTGRESQL_ADDON_PORT
export DB_POSTGRESDB_USER=$POSTGRESQL_ADDON_USER
export DB_POSTGRESDB_PASSWORD=$POSTGRESQL_ADDON_PASSWORD

# Timezone
[ -z "$GENERIC_TIMEZONE" ] && export GENERIC_TIMEZONE="Etc/UTC"

# Security
[ -z "$N8N_BASIC_AUTH_ACTIVE" ] && export N8N_BASIC_AUTH_ACTIVE=true

# Executions
export EXECUTIONS_MODE=queue
export QUEUE_BULL_REDIS_HOST=$REDIS_HOST
export QUEUE_BULL_REDIS_PASSWORD=$REDIS_PASSWORD
[ -z "$QUEUE_BULL_REDIS_DB" ] && export QUEUE_BULL_REDIS_DB=0
export QUEUE_BULL_REDIS_PORT=$REDIS_PORT

# Host
if [ -z "$N8N_HOST" ]
then
    export N8N_HOST=$(echo "$APP_ID" | tr '_' '-').cleverapps.io
fi

echo "Host: $N8N_HOST"
env
./node_modules/.bin/n8n
exit 1
