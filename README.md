# Dockerfile to install parentnode and run the kbhff server

## Requirements

You'll need both `docker` and `docker-compose` installed.

## Building and running

 - Run `sudo docker-compose build` to build the server (currently needs to be done after changing any files).
 - Run `sudo docker-compose up` to start the server.
 - Run `sudo docker-compose down` to stop the server and remove all images.
 - Run `sudo docker exec -it parentnode_docker_apache_1 bash` to log in to the apache image as root (similarly for any of the other images).

## Troubleshooting

 - If you run into problems, try running `sudo docker-compose rm -v` to remove all your volumes, then rebuild. (For example, if you change the passwords for the database, then you need to do this to be able to use the new password.)
