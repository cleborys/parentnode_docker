# Dockerfile to install parentnode and run the kbhff server

## Requirements

You'll need both `docker` and `docker-compose` installed.

## Building and running

 - Before building, you need to download all the git repositories (ubuntu_environment, janitor and kbhff_dk) into the git/ directory, then patch them using the `scripts/apply_patches.sh` script. This step should be automated soon ;)
 - Run `sudo docker-compose build` to build the server (currently needs to be done after changing any files). Add the flag `--no-cache` to not use the build cache if necessary.
 - Run `sudo docker-compose up` to start the server.
 - Run `sudo docker-compose down` to stop the server and remove all images. Add the flag `-v` to also remove all volumes and networks (which will in particular wipe the database).
 - Run `sudo docker exec -it parentnode_docker_apache_1 bash` to log in to the apache image as root (similarly for any of the other images).

## Janitor settings

Ideally in the future the script will autofill these values, but for now they need to be filled by hand.

 - Database name is `kbhff_dk`
 - Database user is `kbhffdk`
 - Database password is `localpass`
 - Database URL is `db`
 - Database root user is `root`
 - Database root password is `averysecurepassword`

## Troubleshooting

 - If you run into problems, try running `sudo docker-compose rm -v` to remove all your volumes, then rebuild. (For example, if you change the passwords for the database, then you need to do this to be able to use the new password.)
 - If you want to re-run the janitor setup process, it seems sufficient to re-create the apache image using `docker-compose build` (you might need to use `--no-cache` if you haven't altered the code since the last build).
