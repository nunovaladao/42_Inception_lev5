NAME = Inception
DOCKER_PATH = ./srcs/docker-compose.yml

# build:
# 	@ echo "Building docker Images (mariadb, wordpress, nginx)"
# 	@ docker build -t mariadb:42 ./srcs/requirements/mariadb
# 	docker build -t wordpress ./srcs/wordpress
# 	docker build -t nginx ./srcs/nginx

up:
	@ echo "Starting docker containers"
	@ docker compose -f $(DOCKER_PATH) up --build

exec:
	@ echo "Starting docker containers"
	@ docker exec -it mariadb mysql -u root -p

rm:
	@ echo "Removing docker containers"
	@ docker rm -f mariadb

rmi:
	@ echo "Removing docker images"
	@ docker rmi -f mariadb:42

down:
	@ echo "Stopping docker containers"

# .PHONY: up down