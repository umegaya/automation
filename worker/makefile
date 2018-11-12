NETWORK=automation-nw
SERVICE=worker
# by default, use jenkins
IMAGE=umegaya/jenkins
WORKER_OPT=--prefix=/worker
VSRC=jenkins
VDST=/var/jenkins_home

service:
	-docker service rm $(SERVICE)
	docker service create --name $(SERVICE) --user root --network $(NETWORK) \
		--mount type=volume,source=$(VSRC),destination=$(VDST) \
		--mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
		--mount type=bind,source=$(HOME)/.docker/machine,target=/root/.docker/machine \
		--mount type=bind,source=$(HOME)/.docker/machine,target=$(HOME)/.docker/machine \
		--mount type=bind,source=/etc/letsencrypt,target=/etc/letsencrypt \
		$(IMAGE) $(WORKER_OPT)

image:
	docker build -t $(IMAGE) .
