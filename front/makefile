HOST=
IMAGE=

.PHONY: config
config:
	@if [ -z "$(HOST)" ]; then echo "specify HOST=your.host.name"; exit 1; fi
	@cat src/main.conf.tmpl | sed -e s/YOUR_HOST_NAME/$(HOST)/g > config/main.conf
	@mkdir -p config/locations && cp -r src/locations/* config/locations/

image: config
	@if [ -z "$(IMAGE)" ]; then echo "specify IMAGE=org/image_name"; exit 1; fi
	@docker build -t $(IMAGE) .

