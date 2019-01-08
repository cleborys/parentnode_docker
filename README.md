Dockerfile to install parentnode and run the kbhff server

Might require sudo:
 - `docker build -t parentnode - < parentNodeDockerFile` to build a docker image
 - `docker images` to view a list of all present images
 - `docker run -p 80:80 -t parentnode` to connect to the image. You can then connect to the apache server by navigating to `localhost:80` in your browser.
 - If you want an interactive shell, remove the last `CMD` line from `parentNodeDockerFile`, rebuild the image, and use the `-i` (interactive) flag in the `run` command. You will then have to manually start `apache2` using `service apache2 start`
