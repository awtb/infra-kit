up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose down
	docker compose up -d

ps:
	docker compose ps

reset:
	docker compose down -v

wipe-postgres:
	docker volume rm infra_kit_postgres_data

wipe-redis:
	docker volume rm infra_kit_redis_data

psql:
	docker exec -it infra_kit_postgres psql -U app -d app

up-%:
	docker compose up -d $*

up-mq:
	docker compose --profile mq up -d rabbitmq

up-adminer:
	docker compose --profile adminer up -d adminer

up-pgadmin:
	docker compose --profile pgadmin up -d pgadmin

wipe-rabbitmq:
	docker compose --profile mq stop rabbitmq || true
	docker compose --profile mq rm -f rabbitmq || true
	docker volume rm -f infra_kit_rabbitmq_data
	docker compose --profile mq up -d rabbitmq

wipe-all:
	docker compose down -v

wipe-%:
	docker compose stop $* || true
	docker compose rm -f $* || true
	docker volume rm -f infra_kit_$*_data || true

stop-%:
	docker compose stop $*

logs-%:
	docker compose logs -f $*
