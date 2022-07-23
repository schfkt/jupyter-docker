DOCKER?=docker
IMAGE=jupyter-lab

.PHONY: build
build:
	${DOCKER} build -t ${IMAGE} .

.PHONY: run
run:
	${DOCKER} run -p 8888:8888 ${IMAGE}
