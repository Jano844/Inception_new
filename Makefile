

COMPOSE = docker compose -f ./srcs/docker-compose.yml

.PHONY: all build up down start stop restart logs clean remove delete

all: build up

# Build containers
build:
	if [ ! -d $(HOME)/data/wordpress ]; then mkdir -p $(HOME)/data/wordpress; fi
	if [ ! -d $(HOME)/data/mariadb ]; then mkdir -p $(HOME)/data/mariadb; fi
	$(COMPOSE) build

# Start containers
up:
	$(COMPOSE) up -d

# Shut down containers
down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart:
	$(COMPOSE) restart

remake:
	$(COMPOSE) build
	$(COMPOSE) up

logs:
	$(COMPOSE) logs -f

clean: down
	$(COMPOSE) rm -f
	$(COMPOSE) volume rm $(shell $(COMPOSE) volume ls -q)

remove:
	@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	@if [ -n "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa); fi
	@if [ -n "$$(docker images -qa)" ]; then docker rmi -f $$(docker images -qa); fi
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	@if [ -n "$$(docker network ls -q)" ]; then docker network rm $$(docker network ls -q) 2>/dev/null || true; fi
