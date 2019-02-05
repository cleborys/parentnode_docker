default: run

download:
	mkdir -p git
#TODO: git clone
#TODO: apply patches










mysql_password=secretpassword
#run_options = --name parentnode-apache -p 80:80 -t parentnode-apache --link parentnode-mariadb:mysql
run_options = -p 80:80 -t parentnode-apache

parentnode:
	sudo docker build -t parentnode-apache -f apache/Dockerfile .

mariadb:
	sudo docker run --name parentnode-mariadb -e MYSQL_ROOT_PASSWORD=$(mysql_password) -d mariadb:latest

redis:
	sudo docker run --name parentnode-redis -d redis:5-alpine

run: #redis mariadb parentnode
	sudo docker run $(run_options)

irun: redis mariadb parentnode
	sudo docker run -i $(run_options)

clean:
	sudo docker system prune -a
