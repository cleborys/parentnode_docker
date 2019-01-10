default: build run

build:
	sudo docker build - -t parentnode < parentnodeDockerFile

run_options = -p 80:80 -t parentnode

run:
	sudo docker run $(run_options)

irun:
	sudo docker run -i $(run_options)
