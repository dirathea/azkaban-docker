VERSION ?= latest

base-build:
	docker build --rm -f "base/Dockerfile" -t dirathea/azkaban-base:$(VERSION) base
	docker push dirathea/azkaban-base:$(VERSION)

solo: base-build
	docker build --rm -f "solo-server/Dockerfile" -t dirathea/azkaban-solo:$(VERSION) solo-server
	docker push dirathea/azkaban-solo:$(VERSION)

web: base-build
	docker build --rm -f "web/Dockerfile" -t dirathea/azkaban-web:$(VERSION) web
	docker push dirathea/azkaban-web:$(VERSION)

executor: base-build
	docker build --rm -f "executor/Dockerfile" -t dirathea/azkaban-executor:$(VERSION) executor
	docker push dirathea/azkaban-executor:$(VERSION)

multi-executor: web executor

all: solo web executor