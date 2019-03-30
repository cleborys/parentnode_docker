# Dockerfile to install parentnode and run the kbhff server

## Requirements

You'll need:
 - `docker`
 - `docker-compose`
 - `git` and `wget` for the script that clones and patches the repositories

## Building and running

 - Before building, run `download_and_patch.bash` to clone the git repositories and patch all the files that need patching for the website to work.
 - Run `sudo docker-compose build` to build the server (currently needs to be done after changing any files). Add the flag `--no-cache` to not use the build cache if necessary.
 - Run `sudo docker-compose up` to start the server.

You can then go to http://kbhff.local/janitor/admin/setup to set up janitor using the settings below.


## Janitor settings

Ideally in the future the script will autofill these values, but for now they need to be filled by hand.

 - Database name is `kbhff_dk`
 - Database user is `kbhffdk`
 - Database password is `localpass`
 - Database URL is `db`
 - Database root user is `root`
 - Database root password is `averysecurepassword`

## Troubleshooting

 - If you get an error message similar to

```
2018/02/25 00:41:13 Error: start: Cannot start container ba9864d582689637dd87aeace7478b8c7200d209102b8cb6d54702059eeddc5a: Port already in use: 80
```

then you probably already have apache running on your local machine. You can either stop apache before starting docker, or make apache run on a non-standard port (i.e. not 80), or make docker run on a non-standard port by altering the port binding in the docker-compose.yml file. If you use the last of these options, then remember that connecting to `kbhff.local` won't work, as you'll need to specify whichever non-standard port you chose.
 - Run `sudo docker-compose down` to stop the server and remove all images. Add the flag `-v` to also remove all volumes and networks (which will in particular wipe the database).
 - Run `sudo docker exec -it parentnodedocker_apache_1 bash` to log in to the apache image as root (similarly for any of the other images).
 - If you run into problems, try running `sudo docker-compose rm -v` to remove all your volumes, then rebuild. (For example, if you change the passwords for the database, then you need to do this to be able to use the new password.)
 - If you want to re-run the janitor setup process, it seems sufficient to re-create the apache image using `docker-compose build` (you might need to use `--no-cache` if you haven't altered the code since the last build).
