.PHONY: \
	all \
	podman.all \
	podman.clean \
	podman.create_pod \
	symfony.all \
	symfony.create_db \
	symfony.schema_up \
	symfony.fixtures
all: \
	podman.all \
	symfony.all

podman.clean:
	podman pod rm -f my-project-pod
podman.create_pod:
	podman pod create --name my-project-pod -p 8080:80
podman.build_web_container:
	podman build -t jslmorrison/apache-web-base:latest -f docker/Dockerfile
podman.run_containers:
	podman run --name=my-web-base -d -v /var/home/johnm/my-temp-project:/var/www/html:Z --pod=my-project-pod apache-web-base:latest
	podman run --name="my-db" -d --pod=my-project-pod -e MYSQL_ROOT_PASSWORD="root" -e MYSQL_DATABASE="my_project" -e MYSQL_USER="web" -e MYSQL_PASSWORD="web" mariadb
podman.all: \
	podman.clean \
	podman.create_pod \
	podman.build_web_container \
	podman.run_containers

symfony.create_db:
	echo 'DATABASE_URL="mysql://web:web@127.0.0.1/my_project?serverVersion=mariadb-10.5.8"' > .env.local
	sleep 10
	podman exec -it my-web-base php bin/console doc:database:create --if-not-exists
symfony.schema_up:
	podman exec -it my-web-base php bin/console doc:sch:up --force
symfony.fixtures:
	podman exec -it my-web-base php bin/console doc:fix:load -n
symfony.all: \
	symfony.create_db \
	symfony.schema_up \
	symfony.fixtures
