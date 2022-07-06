docker compose down
docker volume rm `docker volume ls -q`
docker container prune
docker image prune
docker volume prune
#docker rmi -f `docker images -qa`
docker network rm `docker network ls -q`
