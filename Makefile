current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t mukhin/spark-base:$(current_branch) ./base
	docker build -t mukhin/spark-master:$(current_branch) ./master
	docker build -t mukhin/spark-worker:$(current_branch) ./worker
	docker build -t mukhin/spark-submit:$(current_branch) ./submit

push:
	docker push mukhin/spark-base:$(current_branch)
	docker push mukhin/spark-master:$(current_branch)
	docker push mukhin/spark-worker:$(current_branch)
	docker push mukhin/spark-submit:$(current_branch)
