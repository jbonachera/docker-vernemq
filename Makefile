all: clean build docker
clean:
	docker run -v $$(pwd)/release:/mnt/release --rm -it $$(docker build  -qf Dockerfile.build .) rm -rf /mnt/release/*
build:
	docker run -v $$(pwd)/release:/mnt/release --rm -it $$(docker build  -qf Dockerfile.build .)
docker:
	docker build  -t jbonachera/vernemq  .
