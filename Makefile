.PHONY: help build serve push

help:
	@echo "Targets:"
	@echo "    serve"
	@echo "    build"
	@echo "    push"

build:
	hugo

serve:
	hugo serve -D --watch

push: build
	rsync -vaz public/ nick:/var/www/but-i-digress
