.PHONY = help build serve push

help:
	@echo "Targets:"
	@echo "    build"
	@echo "    serve"
	@echo "    push"

build:
	hugo

serve:
	hugo serve -D --watch

push:
	rsync -vaz public/ nick:/var/www/but-i-digress
