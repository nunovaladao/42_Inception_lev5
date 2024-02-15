NAME = Inception
DOCKER_PATH = ./srcs/docker-compose.yml


all: up

up:
	@ echo "Starting docker containers"
	@ docker compose -f $(DOCKER_PATH) up --build

exec:
	@ echo "Starting docker containers"
	@ docker exec -it mariadb mariadb -u root -p

rm:
	@ echo "Removing docker containers"
	@ docker rm -f mariadb

rmi:
	@ echo "Removing docker images"
	@ docker rmi -f mariadb:42

down:
	@ echo "Stopping docker containers"
	@ docker compose -f $(DOCKER_PATH) down -v

# .PHONY: up down