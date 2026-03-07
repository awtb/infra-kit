# Infra kit

Local development infrastructure: PostgreSQL, Redis, Adminer, pgAdmin, RabbitMQ (optional), VictoriaMetrics stack (optional), Vector log collector (optional).
Managed via docker compose.

## Requirements
- Docker
- Make

## Quick start

```bash
cp .env.example .env
make up
```

## Services & ports

- PostgreSQL: `POSTGRES_PORT` (default `5432`)
- Redis: `REDIS_PORT` (default `6379`)
- Adminer (optional profile `adminer`): `ADMINER_PORT` (default `8080`)
- pgAdmin (optional profile `pgadmin`): `8035` (UI)
- RabbitMQ (optional profile `mq`): `5672` (AMQP), `15672` (UI)
- VictoriaMetrics (optional profile `metrics`): `VICTORIA_METRICS_PORT` (default `8428`, UI at `/vmui`)
- VictoriaLogs (optional profile `metrics`): `VICTORIA_LOGS_PORT` (default `9428`)
- Grafana (optional profile `metrics`): `GRAFANA_PORT` (default `3000`)
- Vector (optional profile `metrics`): collects Docker logs and sends them to VictoriaLogs

## Common commands

```bash
make up # starts postgres + redis
make down
make restart
make reset
```

## Optional services

```bash
make up-adminer
make up-pgadmin
make up-mq
make up-metrics
make up-logs
make up-grafana
make up-vector
```

## Vector container filtering

Vector reads Docker logs from the same host. You can restrict which containers are collected via allowlist/denylist rules in `data/vector/vector.toml`.

```toml
[sources.docker]
include_containers = ["my_api_1"]
include_images = ["ghcr.io/my-org/my-api:dev"]
include_labels = ["com.my-org.logs.collect=true"]

exclude_containers = ["infra_kit_vector"]
exclude_images = []
exclude_labels = []
```

For containers from another `compose.yaml`, label them and include that label in `include_labels`:

```yaml
services:
  my-api:
    labels:
      com.my-org.logs.collect: "true"
```

## Start a specific service

```bash
make up-service-name
```

## Wipe data for a service

```bash
make wipe-postgres
make wipe-redis
make wipe-rabbitmq
make wipe-service-name
```

## Wipe all data

```bash
make wipe-all
```

## Get into psql

```bash
make psql
```
