all: .build

.build: Dockerfile
	docker build .

squashed: .build squashed/Dockerfile
	docker build squashed
