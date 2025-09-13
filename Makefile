.PHONY = help build serve push
INTERFACE = 127.0.0.1

help:
	@echo "Targets:"
	@echo "    serve"
	@echo "    build"
	@echo "    debugbuild"
	@echo "    push"
	@echo "    INTERFACE=$(INTERFACE)"

build:
	hugo

debugbuild:
	hugo --buildDrafts --buildFuture --buildExpired --logLevel debug

serve:
	hugo serve --watch --buildDrafts --buildFuture --bind=0.0.0.0 --baseURL=http://$(INTERFACE) --port=8000 --logLevel debug

push: build
	rsync -vaz public/ nick:/var/www/but-i-digress
