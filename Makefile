all: start

start:
	docker-compose up -d
	sleep 10
	bash start-chronos.sh

stop:
	docker-compose down

clean: stop
	rm -rf data 2>/dev/null || true
