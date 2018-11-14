define env
$(shell . ./.env && echo $${$1})
endef

FRONT_IMAGE=$(call env,AMTN_FRONT_IMAGE)
HOSTNAME=$(call env,AMTN_HOSTNAME)
WORKER_IMAGE=$(call env,AMTN_WORKER_IMAGE)

.PHONY: front worker

front:
	make -C front image IMAGE=$(FRONT_IMAGE) HOST=$(HOSTNAME)

worker:
	make -C worker image IMAGE=$(WORKER_IMAGE)

up:
	. ./.env && docker-compose up -d

down:
	. ./.env && docker-compose down
