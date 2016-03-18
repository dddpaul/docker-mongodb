all: build

build:
	@docker build --tag=sameersbn/mongodb .

release: build
	@docker build --tag=sameersbn/mongodb:$(shell cat VERSION) .
