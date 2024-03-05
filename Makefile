NAME = Inception
DOCKER_PATH = ./srcs/docker-compose.yml


all: up

check_volume_folder:
	@ if [ ! -d "/home/nuno/data/db " ] || [! -d "/home/nuno/data/wp" ]; then \
	mkdir -p /home/nuno/data/db /home/nuno/data/wp; \
	fi # need to change for my login

up: check_volume_folder
	@ echo "Starting docker containers"
	@ docker compose -f $(DOCKER_PATH) up --build

down:
	@ echo "Stopping/Remove docker containers"
	@ docker compose -f $(DOCKER_PATH) down --rmi all -v
	@ sudo rm -rf /home/nuno/data

.PHONY: all up down