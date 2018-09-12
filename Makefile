BIN_DIR                := $(shell pwd)/bin
DB_DIR                := $(shell pwd)/db
DOCKER_COMPOSE_YAML    := docker-compose.yml
DOCKER_COMPOSE         := $(shell pwd)/bin/docker-compose
DOCKER_COMPOSE_CMD     := $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_YAML)
DOCKER_COMPOSE_VERSION := 1.14.0
DBCONFIG               := $(DB_DIR)/dbconfig.yml
MIGRATION_DIR          := $(DB_DIR)/migrations
PASS                   := treasure # for development

install: $(DOCKER_COMPOSE) $(DBCONFIG) $(MIGRATION_DIR)

up: install
	$(DOCKER_COMPOSE_CMD) up -d
	$(MAKE) .set-lang

rm: install stop
	$(DOCKER_COMPOSE_CMD) rm
	@rm -rf mysql-data/
	@rm .set-lang

stop:
	$(DOCKER_COMPOSE_CMD) stop

debug/mysql: .set-lang
	$(DOCKER_COMPOSE_CMD) exec mysql mysql -u treasure -p$(PASS) treasure

debug/app: .set-lang
	$(DOCKER_COMPOSE_CMD) run --rm app bash

query: .set-lang
	$(DOCKER_COMPOSE_CMD) exec mysql mysql -u treasure -p$(PASS) treasure -e "$(shell cat "$(FILE)")"

migrate/status:
	$(DOCKER_COMPOSE_CMD) run --rm app bash -c "sql-migrate status"

migrate/up:
	$(DOCKER_COMPOSE_CMD) run --rm app bash -c "sql-migrate up"

migrate/down:
	$(DOCKER_COMPOSE_CMD) run --rm app bash -c "sql-migrate down"

migrate/new:
	$(DOCKER_COMPOSE_CMD) run --rm app bash -c "sql-migrate new $(NAME)"

migrate/dryrun:
	$(DOCKER_COMPOSE_CMD) run --rm app bash -c "sql-migrate up -dryrun"

db/reset:
	$(DOCKER_COMPOSE_CMD) exec mysql mysql -u treasure -p$(PASS) -e "DROP DATABASE treasure; CREATE DATABASE treasure;"

test:
	$(MAKE) query FILE=app/sql/q2.sql
	$(MAKE) query FILE=app/sql/q3.sql

$(DOCKER_COMPOSE): $(BIN_DIR)
	curl -L https://github.com/docker/compose/releases/download/$(DOCKER_COMPOSE_VERSION)/docker-compose-$(shell uname -s)-$(shell uname -m) > $@
	chmod +x $@
	$@ version

.set-lang:
	$(DOCKER_COMPOSE_CMD) exec mysql apt-get update
	$(DOCKER_COMPOSE_CMD) exec mysql apt-get install -y locales
	$(DOCKER_COMPOSE_CMD) exec mysql localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8
	touch $@


$(BIN_DIR):
	mkdir $@

$(DBCONFIG): $(DB_DIR)
	cp dbconfig.yml.tmpl $(DBCONFIG)

$(DB_DIR):
	mkdir $@

$(MIGRATION_DIR):
	mkdir $@
