all: build docker
build:
	docker run -v $$(pwd)/release:/mnt/release --rm -it $$(docker build  -qf Dockerfile.build .)
docker:
	docker build  -t jbonachera/vernemq  .
