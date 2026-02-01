# Infra kit

Local development infrastructure: PostgreSQL, Redis, Adminer, RabbitMQ (optional).
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
- Adminer: `ADMINER_PORT` (default `8080`)
- RabbitMQ (optional profile `mq`): `5672` (AMQP), `15672` (UI)

## Common commands

```bash
make up # starts all services except mq
make down
make restart
make reset
```

## Optional RabbitMQ

```bash
make up-mq
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
