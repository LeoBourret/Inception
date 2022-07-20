all:
	sudo mkdir -p /home/lebourre/data
	sudo mkdir -p /home/lebourre/data/mysql
	sudo mkdir -p /home/lebourre/data/wp
	sudo chmod -R 777 /home/lebourre/data
	docker compose -f srcs/docker-compose.yaml up --build

clean:
	docker compose -f srcs/docker-compose.yaml down
	docker container prune
	docker image prune
	docker volume rm -f `docker volume ls`
	docker network prune
	sudo rm -rf /home/lebourre/data/mysql
	sudo rm -rf /home/lebourre/data/wp


re: clean all
