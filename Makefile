all: start

start:
	docker-compose up -d

stop:
	docker-compose down

clean: stop
	rm -rf data 2>/dev/null || true
