all: init build run

init:

build:
	docker-compose build

run:
	docker-compose down
	docker-compose up -d