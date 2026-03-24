# Infra kit

Local development infrastructure: PostgreSQL, Redis, Adminer, pgAdmin, RabbitMQ (optional), VictoriaMetrics stack with `vmagent` (optional), Vector log collector (optional).
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
- vmagent (optional profile `metrics`): `VMAGENT_PORT` (default `8429`, Prometheus scraper/forwarder for VictoriaMetrics)
- VictoriaLogs (optional profile `metrics`): `VICTORIA_LOGS_PORT` (default `9428`)
- Grafana (optional profile `metrics`): `GRAFANA_PORT` (default `3000`)
- Vector (optional profile `metrics`): collects Docker logs and sends them to VictoriaLogs
- Metrics/logging endpoints are configurable via `.env`: `VMAGENT_REMOTE_WRITE_URL`, `VMAGENT_SCRAPE_JOB_NAME`, `VMAGENT_SCRAPE_PATH`, `VMAGENT_SCRAPE_TARGET`, `VECTOR_VICTORIA_LOGS_URI`

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

## Metrics stack

`make up-metrics` starts VictoriaMetrics, VictoriaLogs, vmagent, Vector, and Grafana.

`vmagent` scrapes a single target configured via `.env`:

```bash
VMAGENT_SCRAPE_JOB_NAME=app
VMAGENT_SCRAPE_PATH=/metrics
VMAGENT_SCRAPE_TARGET=host.docker.internal:8000
```

Vector forwards Docker logs to VictoriaLogs. Its sink endpoint is configurable via:

```bash
VECTOR_VICTORIA_LOGS_URI=http://victoria_logs:9428/insert/jsonline
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
make wipe-vm
make wipe-grafana
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
