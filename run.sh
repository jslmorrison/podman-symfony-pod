#!/bin/bash

echo "Bringing up the pod and containers"
echo "Creating pod"
podman pod create --name my-project-pod -p 8080:80
echo "Building container from Dockerfile"
podman build -t jslmorrison/apache-web-base:latest -f docker/Dockerfile
echo "Run web container in pod"
podman run --name=my-web-base -d -v /var/home/johnm/my-temp-project:/var/www/html:Z --pod=my-project-pod apache-web-base:latest
echo "Run db container in pod"
podman run --name="my-db" -d --pod=my-project-pod -e MYSQL_ROOT_PASSWORD="root" -e MYSQL_DATABASE="my_project" -e MYSQL_USER="web" -e MYSQL_PASSWORD="web" mariadb
echo "Set the database dsn"
echo 'DATABASE_URL="mysql://web:web@127.0.0.1/my_project?serverVersion=mariadb-10.5.8"' > .env.local
echo "Create the database"
sleep 2
podman exec -it my-web-base php bin/console doc:database:create --if-not-exists
echo "Bring schema up to date"
podman exec -it my-web-base php bin/console doc:sch:up --force
echo "Load fixtures"
podman exec -it my-web-base php bin/console doc:fix:load -n
