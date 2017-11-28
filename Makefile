IMG_NAME 	:= quay.io/erudatum/gethwork
VERSION 	?= latest
DATAROOT 	:= ${CURDIR}
CONTAINER_NAME := ethereum

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

img:              	## Builds docker image
	@docker build -f Dockerfile --rm -t $(IMG_NAME):master .
	@docker tag $(IMG_NAME):master $(IMG_NAME)

push:             	## Push docker image to registry
	@docker push $(IMG_NAME)

rel-img: tag img  	## [RELEASE] Build release image
	@docker tag $(IMG_NAME):master $(IMG_NAME):$(tag)

rel-push: rel-img 	## [RELEASE] Push release image to registry
	@echo "Publishing release $(IMG_NAME):$(tag)"
	@docker push $(IMG_NAME):$(tag)

tag:
	$(eval tag := $(shell git describe --tags `git rev-list --tags --max-count=1`))

# --------------------------------------
# Deployment Strategies

btnd-up:		## Bring boot node up
	@docker run -d -it --name $(CONTAINER_NAME)-bootnode -v $(DATAROOT).bootnode:/root --network ethereum -e "RUN_BOOTNODE=true" $(IMG_NAME)

btnd-down: 		## Clean up instances
	@docker stop $(CONTAINER_NAME)-bootnode
	@docker rm $(CONTAINER_NAME)-bootnode

# import node configuration
# You can change the default node config with `make node-cnf="config_special.env" node-up`
node-cnf ?= node.env
include $(node-cnf)
export $(shell sed 's/=.*//' $(node-cnf))
ENODE_LINE = $(shell docker logs $(CONTAINER_NAME)-bootnode 2>&1 | grep enode | head -n 1)
BOOTNODE_URL = enode:$(lastword $(subst enode:, ,$(ENODE_LINE)))

node-up:		## Fire up a non-mining node. Depends on node.env; Depends on bootnode up
	@docker run -d --name $(CONTAINER_NAME)-$(NODE_NAME) -v $(DATAROOT)/.ether-$(NODE_NAME):/root --network ethereum -e "BOOTNODE_URL=$(BOOTNODE_URL)" $(IMG_NAME) --identity $(NODE_NAME) --cache=512 --verbosity=4 --maxpeers=3

node-down:
	@docker stop $(CONTAINER_NAME)-$(NODE_NAME)
	@docker rm $(CONTAINER_NAME)-$(NODE_NAME)


