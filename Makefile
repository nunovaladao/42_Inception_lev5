NAME = Inception
DOCKER_PATH = ./srcs/docker-compose.yml


all: up

up:
	@ echo "Starting docker containers"
	@ docker compose -f $(DOCKER_PATH) up --build

down:
	@ echo "Stopping/Remove docker containers"
	@ docker compose -f $(DOCKER_PATH) down --rmi all -v

# .PHONY: up down