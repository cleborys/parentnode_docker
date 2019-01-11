Dockerfile to install parentnode and run the kbhff server

Might require sudo:
 - `make build` to build a docker image
 - `docker images` to view a list of all present images
 - `make run` to run the image (currently disabled until we've implemented mysql and redis as separate containers)
 - `make irun` to launch a shell in the image: if you want to access the website, you will need to manually start apache, mysql and redis using `service apache2 start` and `service mysql start` and `redis-server`
