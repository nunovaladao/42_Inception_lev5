NAME = Inception
DOCKER_PATH = ./srcs/docker-compose.yml


all: up

check_host:
	@ if ! grep -q "127.0.0.1 nsoares-.42.fr" /etc/hosts; then \
		echo "Creating host entry..."; \
		echo "127.0.0.1 nsoares-.42.fr" | sudo tee -a /etc/hosts; \
	else \
		echo "Host entry already exists."; \
	fi

check_volume_folder:
	@ if [ ! -d "/home/nuno/data/db" ] || [ ! -d "/home/nuno/data/wp" ]; then \
	mkdir -p /home/nuno/data/db /home/nuno/data/wp; \
	fi # need to change for my login

up: check_host check_volume_folder
	@ echo "Starting docker containers"
	@ docker compose -f $(DOCKER_PATH) up --build

down:
	@ echo "Stopping/Remove docker containers"
	@ docker compose -f $(DOCKER_PATH) down --rmi all -v
	@ sudo rm -rf /home/nuno/data # need to change for my login

.PHONY: all up down