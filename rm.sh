docker compose down
docker volume rm `docker volume ls -q`
#docker rmi -f `docker images -qa`
docker network rm `docker network ls -q`
