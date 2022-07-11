all:
	sudo mkdir -p /Users/lebourre/data
	sudo mkdir -p /Users/lebourre/data/mysql
	sudo mkdir -p /Users/lebourre/data/wp
	sudo chmod -R 777 /Users/lebourre/data
	docker compose -f srcs/docker-compose.yaml up --build

clean:
	docker compose -f srcs/docker-compose.yaml down
	docker container prune
	docker image prune
	docker volume prune
	docker network prune
	sudo rm -rf /Users/lebourre/data/mysql
	sudo rm -rf /Users/lebourre/data/wp


re: clean all
