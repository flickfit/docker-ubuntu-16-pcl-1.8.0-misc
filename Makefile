NAME=ubuntu-16-pcl-1.8.0-misc
FULLNAME=flickfit/$(NAME)
VERSION=latest

build:
	docker build -t $(FULLNAME):$(VERSION) .

restart: stop start

start:
	docker run -itd \
		--name $(NAME) \
		$(FULLNAME):$(VERSION) bash

contener=`docker ps -a -q`
image=`docker images | awk '/^<none>/ { print $$3 }'`

clean:
	@if [ "$(image)" != "" ] ; then \
		docker rmi $(image); \
		fi
	@if [ "$(contener)" != "" ] ; then \
		docker rm $(contener); \
		fi

stop:
	docker rm -f $(NAME)

attach:
	docker exec -it $(NAME) /bin/bash

logs:
	docker logs $(NAME)

run:
	docker run -it $(FULLNAME):$(VERSION) /bin/bash

push:
	docker push $(FULLNAME):$(VERSION)
