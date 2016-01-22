# Initialize data and persistent in docker mysql

> This is a sample by inserting the initial data in the mysql database at the start-up docker container.
And it shows how to persist data.

### require

- [virtualbox](https://www.virtualbox.org/)
- [docker-machine](https://docs.docker.com/machine/)
- [docker-compose](https://docs.docker.com/compose/)

### how to

#### Introduction of initial data

Create Database and Insert initial data.

```sh
docker-compose up -d

docker ps
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                    NAMES
3e3ad4a65c98        dockermysql_app_server    "apache2-foreground"     2 hours ago         Up 8 seconds        80/tcp                   app_server_1
eb3e8d83aa7c        mysql:5.5                 "/entrypoint.sh mysql"   2 hours ago         Up 2 hours          0.0.0.0:3306->3306/tcp   mysql_server_1

PHP_CONTAINER_NAME=app_server_1

# Connection mysql container from mysql client container.
# Mysql server and the mysql client server has been link.

docker exec -t $PHP_CONTAINER_NAME mysql -u test -ppassword -h mysql -e "use sample_db; select * from personal;"
+----+------------+
| id | name       |
+----+------------+
|  1 | root@local |
+----+------------+
```

#### Persistence of data

```sh
docker-compose up -d

docker ps
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                    NAMES
3e3ad4a65c98        app_server               "apache2-foreground"     2 hours ago         Up 8 seconds        80/tcp                   app_server_1
eb3e8d83aa7c        mysql:5.5                "/entrypoint.sh mysql"   2 hours ago         Up 2 hours          0.0.0.0:3306->3306/tcp   mysql_server_1

PHP_CONTAINER_NAME=app_server_1

docker exec -t $PHP_CONTAINER_NAME mysql -u test -ppassword -h mysql -e "use sample_db; insert personal (id, name) values (2, 'admin@local');"

docker exec -t $PHP_CONTAINER_NAME mysql -u test -ppassword -h mysql -e "use sample_db; select * from personal;"

+----+------------+
| id | name       |
+----+------------+
|  1 | root@local |
|  2 | admin@loca |
+----+------------+
```

#### Get backup data

```sh
docker run --rm --volumes-from <STORAGE CONTAINER> -v $(pwd):/backup app:latest tar czvf /backup/archive.tar.gz /var/lib/mysql
```
