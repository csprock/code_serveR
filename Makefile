
# Run arguments
R_VERSION := 4.1.2


build:
	docker build . \
		--tag csprock/vscodebase:${R_VERSION} \
		--build-arg R_VERSION=${R_VERSION}

