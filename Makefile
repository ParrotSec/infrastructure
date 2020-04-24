include env
export

D=docker-compose
EDGE=-f docker-compose.yml -f opennic.yml -f firewall.yml -f edge.yml
MIRROR=-f docker-compose.yml -f firewall.yml -f repository.yml
GIBSON=-f docker-compose.yml -f opennic.yml -f firewall.yml -f repository.yml -f director.yml

ifeq($(GIBSON_ID), 1)
	GIBSON += -f gibson1.yml
else ifeq($(GIBSON_ID), 2)
	GIBSON += -f gibson2.yml
else ifeq($(GIBSON_ID), 3)
	GIBSON += -f gibson3.yml
else
	GIBSON += -f gibson-leaf.yml
endif

edge-stop:
	$(D) $(EDGE) down

edge-update:
	git pull
	$(D) $(EDGE) pull
	$(D) $(EDGE) build
	$(D) $(EDGE) up -d

edge-start:
	$(D) $(EDGE) pull
	$(D) $(EDGE) build
	$(D) $(EDGE) up -d

edge-ps:
	$(D) $(EDGE) ps

edge-logs:
	$(D) $(EDGE) logs

edge: edge-stop edge-update edge-start




gibson-stop:
	$(D) $(GIBSON) down

gibson-update:
	git pull
	$(D) $(GIBSON) pull
	$(D) $(GIBSON) build
	$(D) $(GIBSON) up -d

gibson-start:
	$(D) $(GIBSON) pull
	$(D) $(GIBSON) build
	$(D) $(GIBSON) up -d

gibson-ps:
	$(D) $(GIBSON) ps

gibson-logs:
	$(D) $(GIBSON) logs

gibson: gibson-stop gibson-update




mirror-stop:
	$(D) $(MIRROR) down

mirror-update:
	git pull
	$(D) $(MIRROR) pull
	$(D) $(MIRROR) build
	$(D) $(MIRROR) up -d

mirror-start:
	$(D) $(MIRROR) pull
	$(D) $(MIRROR) build
	$(D) $(MIRROR) up -d

mirror-ps:
	$(D) $(MIRROR) ps

mirror-logs:
	$(D) $(MIRROR) logs

mirror: mirror-stop mirror-update mirror-start



central-stop:
	$(D) $(CENTRAL) down

central-update:
	git pull
	$(D) $(CENTRAL) pull
	$(D) $(CENTRAL) build
	$(D) $(CENTRAL) up -d

central-start:
	$(D) $(CENTRAL) pull
	$(D) $(CENTRAL) build
	$(D) $(CENTRAL) up -d

central: central-stop central-update central-start


ipfs-bootstrap:
	docker-compose exec ipfs ipfs bootstrap add /ip4/51.91.152.156/tcp/4001/p2p/QmTGCxnerPXq77i3w7jPThB93rBbLAJvg1RR4rTsEA8fR6
	docker-compose exec ipfs ipfs bootstrap add /ip4/51.178.92.105/tcp/4001/p2p/QmPdyJpEKNDXe8Ug41siw3pjCyWvmHayFWDqCPbK6YvhoX
	docker-compose exec ipfs ipfs bootstrap add /ip4/51.83.238.32/tcp/4001/p2p/QmUjKeBFqawkMYRLPQQ1gcLtfNjXrb5DMVEyVQfMWRkmxf
	docker-compose exec ipfs ipfs bootstrap add /ip4/51.161.118.148/tcp/4001/p2p/QmSW1JdCDzsELVJtCHsnYTiSWswEJXo1VPPhEgwA9o76Nt
	docker-compose exec ipfs ipfs bootstrap add /ip4/139.99.69.216/tcp/4001/p2p/QmZ3qVBvDHwF1VpbaqFBu1mWeQMHuoTAHocgfPcksghqWN

ipfs-pin:
	docker exec ipfs ipfs pin add /ipns/www.parrotsec.org &
	docker exec ipfs ipfs pin add /ipns/docs.parrotsec.org &
	docker exec ipfs ipfs pin add /ipns/static.parrotsec.org &


reposync:
	docker exec -i updater rsync -PahvHtSxl --delay-updates --delete-after master.rsync.parrot.sh/parrot /var/www/repository/parrot


cleanlogs:


cleancache:


stats:
