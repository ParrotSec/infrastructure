D=docker-compose
EDGE=-f docker-compose.yml -f opennic.yml -f firewall.yml
MIRROR=-f docker-compose.yml -f opennic.yml -f firewall.yml -f repository.yml
GIBSON=-f docker-compose.yml -f opennic.yml -f firewall.yml -f repository.yml -f director.yml
CENTRAL=-f docker-compose.yml -f opennic.yml -f firewall.yml -f repository.yml -f director.yml -f central.yml

edge-down:
	$(D) $(EDGE) down

edge-update:
	git pull
	$(D) $(EDGE) pull
	$(D) $(EDGE) build
	$(D) $(EDGE) up -d

edge-up:
	$(D) $(EDGE) pull
	$(D) $(EDGE) build
	$(D) $(EDGE) up -d

edge-ps:
	$(D) $(EDGE) ps

edge-logs:
	$(D) $(EDGE) logs

edge: edge-down edge-update edge-up




gibson-down:
	$(D) $(GIBSON) down

gibson-update:
	git pull
	$(D) $(GIBSON) pull
	$(D) $(GIBSON) build
	$(D) $(GIBSON) up -d

gibson-up:
	$(D) $(GIBSON) pull
	$(D) $(GIBSON) build
	$(D) $(GIBSON) up -d

gibson-ps:
	$(D) $(GIBSON) ps

gibson-logs:
	$(D) $(GIBSON) logs

gibson: gibson-down gibson-update gibson-up


mirror-down:
	$(D) $(MIRROR) down

mirror-update:
	git pull
	$(D) $(MIRROR) pull
	$(D) $(MIRROR) build
	$(D) $(MIRROR) up -d

mirror-up:
	$(D) $(MIRROR) pull
	$(D) $(MIRROR) build
	$(D) $(MIRROR) up -d

mirror-ps:
	$(D) $(MIRROR) ps

mirror-logs:
	$(D) $(MIRROR) logs

mirror: mirror-down mirror-update mirror-up



central-down:
	$(D) $(CENTRAL) down

central-update:
	git pull
	$(D) $(CENTRAL) pull
	$(D) $(CENTRAL) build
	$(D) $(CENTRAL) up -d

central-up:
	$(D) $(CENTRAL) pull
	$(D) $(CENTRAL) build
	$(D) $(CENTRAL) up -d

central: central-down central-update central-up


ipfspin:
	docker run -ti ipfs ipfs pin /ipns/website.ipfs.parrot.sh
	docker run -ti ipfs ipfs pin /ipns/docs.ipfs.parrot.sh
	docker run -ti ipfs ipfs pin /ipns/static.ipfs.parrot.sh
	docker run -ti ipfs ipfs pin /ipns/speedtest.ipfs.parrot.sh


reposync:


cleanlogs:


cleancache:


stats: