Dockerfile to install parentnode and run the kbhff server

Might require sudo:
 - `make build` to build a docker image
 - `docker images` to view a list of all present images
 - `make run` to run the image
 - `make irun` to launch a shell in the image: you will need to first disable the last 'CMD' line of the docker file. If you want to access the website, you will then need to manually start apache, mysql and redis using `service apache2 start` and `service mysql start` and `redis-server`
