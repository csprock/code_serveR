
.PHONEY: build test clean
SHELL := /bin/bash

# Build arguments
R_VERSION := 4.1.2


TEST_CONTAINER_NAME := vscodebase_test

# Environment variables
PUID = $$(whoami | id -u)
PGID = $$(whoami | id -g)
PORT = 8443
TZ = America/Los_Angeles


build:
	docker build . --tag csprock/vscodebase:${R_VERSION} \
		--build-arg R_VERSION=${R_VERSION}

push:	
	docker image push csprock/vscodebase:{R_VERSION}


test:
	docker run  \
		-e PUID=1000 \
		-e PGID=1000 \
		-e "TZ=$(TZ)" \
		-p $(PORT):8443 \
		-v $$(pwd):/config/workspace \
		--name $(TEST_CONTAINER_NAME) \
	        csprock/vscodebase:$(R_VERSION)

clean:
	docker container rm $(TEST_CONTAINER_NAME)
