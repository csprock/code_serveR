
# Image parameters
VERSION := 0.0

# Run arguments
R_VERSION := 4.1.2


build:
	docker build . \
		--tag csprock/vscodebase:${VERSION} \
		--build-arg R_VERSION=${R_VERSION}
