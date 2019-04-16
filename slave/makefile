IMAGE=umegaya/jenkins_slave
SSH_DIR=$(HOME)/.ssh
SLAVE_PASS=

image:
	docker build -t $(IMAGE) --build-arg SLAVE_PASS=$(SLAVE_PASS) .
	docker run --rm -v `pwd`:/project -v $(SSH_DIR):/home/slave/.ssh -w /project $(IMAGE) bash ./initialize.sh
