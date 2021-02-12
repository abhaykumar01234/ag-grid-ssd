# ag-grid-ssd

## Pre-requisites

docker should be installed

## Run the below commands to start the project

> > docker-compose up -d

<br/>Creating network "ag-grid-ssd_sql-network" with driver "bridge"
<br/>Creating volume "ag-grid-ssd_database" with default driver
<br/>Building node
<br/>Step 1/8 : FROM node:current-alpine
<br/> ---> 90a1b235430e
<br/>Step 2/8 : ENV NODE_ENV=development
<br/> ---> Using cache
<br/> ---> 69e1e2f13890
<br/>Step 3/8 : ENV PORT=4000
<br/> ---> Using cache
<br/> ---> 3dfd22d59705
<br/>Step 4/8 : COPY ./example-project /var/www
<br/> ---> e7fcdab4a10e
<br/>Step 5/8 : WORKDIR /var/www
<br/> ---> Running in c48e5c986b76
<br/>Removing intermediate container c48e5c986b76
<br/> ---> 35611640f3f4
<br/>Step 6/8 : RUN npm install
<br/> ---> Running in a0851877ab16
<br/> .....
<br/> .....
<br/> Removing intermediate container a0851877ab16
<br/> ---> ccbb0b1a04f9
<br/>Step 7/8 : EXPOSE ${PORT}
<br/> ---> Running in 3a0700e22453
<br/>Removing intermediate container 3a0700e22453
<br/> ---> 6fa8a95aa95f
<br/>Step 8/8 : ENTRYPOINT [ "npm", "run", "dev" ]
<br/> ---> Running in df5000ddaf5e
<br/>Removing intermediate container df5000ddaf5e
<br/> ---> 1dabbccbbfe2
<br/>Successfully built 1dabbccbbfe2
<br/>Successfully tagged ag-grid-ssd_node:latest
<br/>WARNING: Image for service node was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
<br/>Creating node_server ... done
<br/>Creating my_sql_adminer ... done
<br/>Creating my_sql_test_db ... done

### check the status of the dockers

> > docker-compose ps
> > <br/>docker-compose logs -f node
> > <br/>docker-compose logs -f db

<br/>Wait for the below lines in the log:
<br/>my_sql_test_db | 2021-02-12 15:35:11+00:00 [Note] [Entrypoint]: Creating database test
<br/>my_sql_test_db | 2021-02-12 15:35:12+00:00 [Note] [Entrypoint]: Creating user user
<br/>my_sql_test_db | 2021-02-12 15:35:13+00:00 [Note] [Entrypoint]: Giving user user access to schema test
<br/>my_sql_test_db |
<br/>my_sql_test_db | 2021-02-12 15:35:13+00:00 [Note] [Entrypoint]: Stopping temporary server
<br/>my_sql_test_db | 2021-02-12T15:35:13.797085Z 13 [System] [MY-013172] [Server] Received SHUTDOWN from user root. Shutting down mysqld (Version: 8.0.23).
<br/>my_sql_test_db | 2021-02-12T15:35:42.721459Z 0 [System] [MY-010910] [Server] /usr/sbin/mysqld: Shutdown complete (mysqld 8.0.23) MySQL Community Server - GPL.
<br/>my_sql_test_db | 2021-02-12 15:35:42+00:00 [Note] [Entrypoint]: Temporary server stopped
<br/>my_sql_test_db |
<br/>my_sql_test_db | 2021-02-12 15:35:42+00:00 [Note] [Entrypoint]: MySQL init process done. Ready for start up.
<br/>my_sql_test_db |
<br/>my_sql_test_db | 2021-02-12T15:35:43.120010Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.23) starting as process 1
<br/>my_sql_test_db | 2021-02-12T15:35:44.271759Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
<br/>my_sql_test_db | 2021-02-12T15:35:45.354207Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
<br/>my_sql_test_db | 2021-02-12T15:35:45.706525Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Bind-address: '::' port: 33060, socket: /var/run/mysqld/mysqlx.sock

> > docker ps

<br/>CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
<br/>6a3687ac3b2c adminer "entrypoint.sh docke…" 5 minutes ago Up 5 minutes 0.0.0.0:8080->8080/tcp my_sql_adminer
<br/>a484d9ae2aec mysql "docker-entrypoint.s…" 5 minutes ago Up 5 minutes 3306/tcp, 33060/tcp my_sql_test_db
<br/>5fc27db51726 ag-grid-ssd_node "npm run dev" 5 minutes ago Up 5 minutes 0.0.0.0:4000->4000/tcp node_server

### Import the data in mysql docker

> > docker exec -it a484d9ae2aec /bin/bash

<br/>root@a484d9ae2aec:/#
<br/>root@a484d9ae2aec:/# cd /mnt/shared/data/
<br/>root@a484d9ae2aec:/mnt/shared/data#
<br/>root@a484d9ae2aec:/mnt/shared/data# mysql -u root -p -D test < ./olympic_winners.sql
<br/>Enter password: example
<br/>root@a484d9ae2aec:/mnt/shared/data#
<br/>root@a484d9ae2aec:/mnt/shared/data# exit
<br/>exit

### Open localhost:8080 and localhost:4000 to start the application

## To stop the dockers

docker-compose down

## To remove the volume and images

docker-compose down --rmi local --remove-orphans -v
