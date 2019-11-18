IMAGE := nilan3/spark
TAG := 2.4.4
ZEPPELIN_VERSION := 0.8.2

build:
	$(info Make: Building images.)
	@docker build --rm -t $(IMAGE)-base:$(TAG) ./spark/images/base
	@docker build --rm -t $(IMAGE)-master:$(TAG) ./spark/images/master
	@docker build --rm -t $(IMAGE)-worker:$(TAG) ./spark/images/worker
	@docker build --rm -t $(IMAGE)-zeppelin:$(TAG)-$(ZEPPELIN_VERSION) ./zeppelin
	@make -s clean

push:
	$(info Make: Pushing images.)
	@docker login
	@docker push $(IMAGE)-base:$(TAG)
	@docker push $(IMAGE)-master:$(TAG)
	@docker push $(IMAGE)-worker:$(TAG)
	@docker push $(IMAGE)-zeppelin:$(TAG)-$(ZEPPELIN_VERSION)

start:
	$(info Make: Starting locastack, zeppelin and spark master/worker containers.)
	@docker-compose up --scale spark-worker=2 -d

stop:
	$(info Make: Stopping all containers)
	@docker-compose stop

destroy:
	$(info Make: Removing all containers)
	@docker-compose down

restart:
	$(info Make: Restarting all containers.)
	@make -s stop
	@make -s start

clean:
	@docker system prune --volumes --force
