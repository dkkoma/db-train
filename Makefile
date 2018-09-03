BIN_DIR                := $(shell pwd)/bin
DB_DIR                := $(shell pwd)/db
DOCKER_COMPOSE_YAML    := docker-compose.yml
DOCKER_COMPOSE         := $(shell pwd)/bin/docker-compose
DOCKER_COMPOSE_CMD     := $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_YAML)
DOCKER_COMPOSE_VERSION := 1.14.0
ENV                    := .env
DBCONFIG               := $(DB_DIR)/dbconfig.yml
MIGRATION_DIR          := $(DB_DIR)/migrations
PASS                   := treasure

install: $(DOCKER_COMPOSE) $(ENV) $(DBCONFIG) $(MIGRATION_DIR)

up: install
	$(DOCKER_COMPOSE_CMD) up -d
	$(MAKE) .set-lang

rm: install stop
	$(DOCKER_COMPOSE_CMD) rm

stop:
	$(DOCKER_COMPOSE_CMD) stop

debug: .set-lang
	$(DOCKER_COMPOSE_CMD) exec mysql mysql -u treasure -p treasure

ssh: .set-lang
	$(DOCKER_COMPOSE_CMD) exec mysql bash

query: .set-lang
	$(DOCKER_COMPOSE_CMD) exec mysql mysql -u treasure -p$(PASS) treasure -e "$(shell cat "$(FILE)")"

migrate/dry:
	

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

$(ENV):
	cp .env.tmpl $(ENV)

$(DBCONFIG): $(DB_DIR)
	cp dbconfig.yml.tmpl $(DBCONFIG)

$(DB_DIR):
	mkdir $@

$(MIGRATION_DIR):
	mkdir $@
