define env
$(shell . ./.env && echo $${$1})
endef

FRONT_IMAGE=$(call env,AMTN_FRONT_IMAGE)
HOSTNAME=$(call env,AMTN_HOSTNAME)
WORKER_IMAGE=$(call env,AMTN_WORKER_IMAGE)
SLAVE_IMAGE=$(call env,AMTN_SLAVE_IMAGE)
SLAVE_PASS=$(call env,AMTN_SLAVE_PASS)

.PHONY: front worker slave

front:
	make -C front image IMAGE=$(FRONT_IMAGE) HOST=$(HOSTNAME)

worker:
	make -C worker image IMAGE=$(WORKER_IMAGE)

slave:
	make -C slave image IMAGE=$(SLAVE_IMAGE) SLAVE_PASS=$(SLAVE_PASS)

up:
	. ./.env && docker-compose up -d

down:
	. ./.env && docker-compose down

sup:
	. ./.env && docker-compose -f ./docker-compose-slave.yml up -d

sdown:
	. ./.env && docker-compose -f ./docker-compose-slave.yml down
