include env
export

D=docker-compose
EDGE=-f docker-compose.yml -f opennic.yml -f firewall.yml -f edge.yml
MIRROR=-f docker-compose.yml -f firewall.yml -f repository.yml
GIBSON=-f docker-compose.yml -f opennic.yml -f firewall.yml -f repository.yml -f director.yml

ifeq ($(GIBSON_ID), 1)
	GIBSON += -f gibson1.yml
else ifeq ($(GIBSON_ID), 2)
	GIBSON += -f gibson2.yml
else ifeq ($(GIBSON_ID), 3)
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

director-feed:
	docker exec director mirrorbits add -http https://mirrors.mit.edu/parrot -rsync rsync://mirrors.mit.edu/parrot -comment "SIPB MIT (1Gbps)" ncsa.mit
	docker exec director mirrorbits add -http https://mirror.clarkson.edu/parrot -rsync rsync://mirror.clarkson.edu/parrot -comment "Clarkson University" ncsa.clarkson
	docker exec director mirrorbits add -http https://ftp.osuosl.org/pub/parrotos -rsync rsync://ftp.osuosl.org/parrotos -comment "Oregon State University - Open Source Lab" ncsa.osuosl
	docker exec director mirrorbits add -http https://mirrors.ocf.berkeley.edu/parrot -rsync rsync://mirrors.ocf.berkeley.edu/parrot -comment "Berkeley Open Computing Facility" ncsa.berkeley
	docker exec director mirrorbits add -http https://muug.ca/mirror/parrot -rsync rsync://muug.ca/parrot -comment "Manitoba Unix User Group" ncsa.muug
	docker exec director mirrorbits add -http https://parrot.mirror.garr.it/parrot -rsync rsync://parrot.mirror.garr.it/parrot -comment "GARR Consortium (Italian Research & Education Network)" emea.garr
	docker exec director mirrorbits add -http https://ftp.halifax.rwth-aachen.de/parrotsec -rsync rsync://ftp.halifax.rwth-aachen.de/parrotsec -comment "RWTH-Aachen (Halifax students group)" emea.halifax
	docker exec director mirrorbits add -http https://ftp-stud.hs-esslingen.de/Mirrors/archive.parrotsec.org -rsync rsync://ftp-stud.hs-esslingen.de/archive.parrotsec.org -comment "Esslingen (University of Applied Sciences)" emea.esslingen
	docker exec director mirrorbits add -http https://ftp.nluug.nl/os/Linux/distr/parrot -rsync rsync://ftp.nluug.nl/parrot -comment "Nluug" emea.nluug
	docker exec director mirrorbits add -http https://ftp.acc.umu.se/mirror/parrotsec.org/parrot -rsync rsync://ftp.acc.umu.se/mirror/parrotsec.org/parrot/ -comment "ACC UMU (Academic Computer Club, Umea University)" emea.umu
	docker exec director mirrorbits add -http https://ftp.cc.uoc.gr/mirrors/linux/parrot -ftp ftp://ftp.cc.uoc.gr/mirrors/linux/parrot/ -comment "UoC (University of Crete - Computer Center)" emea.uoc
	docker exec director mirrorbits add -http https://ftp.belnet.be/pub/archive.parrotsec.org/ -rsync rsync://ftp.belnet.be/parrotsec -comment "Belnet (The Belgian National Research)" emea.belnet
	docker exec director mirrorbits add -http https://matojo.unizar.es/parrot -rsync rsync://matojo.unizar.es/parrot -comment "Osluz (Oficina de software libre de la Universidad de Zaragoza)" emea.osluz
	docker exec director mirrorbits add -http https://mirrors.up.pt/parrot -rsync rsync://mirrors.up.pt/parrot -comment "U.Porto (University of Porto)" emea.up
	docker exec director mirrorbits add -http https://mirrors.dotsrc.org/parrot -rsync rsync://mirrors.dotsrc.org/parrot -comment "Dotsrc (Aalborg university)" emea.dotsrc
	docker exec director mirrorbits add -http https://parrot.mirror.cythin.com/parrot -rsnc rsync://parrot.mirror.cythin.com/parrot -comment "cythin.com" emea.cythin
	docker exec director mirrorbits add -http https://quantum-mirror.hu/mirrors/pub/parrot -rsync rsync://quantum-mirror.hu/mirrors/pub/parrot/ -comment "quantum-mirror.hu" emea.quantum
	docker exec director mirrorbits add -http https://mirror.yandex.ru/mirrors/parrot -rsync rsync://mirror.yandex.ru/mirrors/parrot/ -comment "Yandex Mirror" apac.yandex
	docker exec director mirrorbits add -http http://mirror.truenetwork.ru/parrot -rsync rsync://mirror.truenetwork.ru/parrot -comment "Truenetwork" apac.truenetwork
	docker exec director mirrorbits add -http http://mirrors.comsys.kpi.ua/parrot -rsync rsync://mirrors.comsys.kpi.ua/parrot-iso -comment "KPI (National Technical University of Ukraine - Comsys)" emea.comsys
	docker exec director mirrorbits add -http http://mirror.amberit.com.bd/parrotsec -rsync rsync://mirror.amberit.com.bd/parrotsec -comment "Amberit (Dhakacom)"
	docker exec director mirrorbits add -http https://free.nchc.org.tw/parrot -ftp ftp://free.nchc.org.tw/parrot/ -comment "NCHC (Free Software Lab)" apac.nchc
	docker exec director mirrorbits add -http https://mirror.0x.sg/parrot -rsync rsync://mirror.0x.sg/parrot -comment "0x" apac.0x
	docker exec director mirrorbits add -http https://mirrors.ustc.edu.cn/parrot -rsync rsync://mirrors.ustc.edu.cn/repo/parrot/ -comment "University of Science and Technology of China and USTCLUG" apac.ustc
	docker exec director mirrorbits add -http https://mirror.kku.ac.th/parrot -rsync rsync://mirror.kku.ac.th/parrot -comment "KKU (Khon Kaen University)" apac.kku
	docker exec director mirrorbits add -http http://kartolo.sby.datautama.net.id/parrot -rsync rsync://kartolo.sby.datautama.net.id/parrot -comment "Datautama (PT. Data Utama Dinamika)" apac.datautama
	docker exec director mirrorbits add -http https://mirrors.takeshi.nz/parrot -rsync rsync://mirrors.takeshi.nz/parrot -comment "Takeshi (D T Consulting Ltd)" apac.takeshi
	docker exec director mirrorbits add -http https://http://mirrors.shu.edu.cn/parrot -rsync rsync://http://mirrors.shu.edu.cn/parrot -comment "SHU(Shanghai University)" apac.shu
	docker exec director mirrorbits add -http http://mirrors.sjtug.sjtu.edu.cn/parrot -rsync rsync://mirrors.sjtug.sjtu.edu.cn/parrot -comment "SJTUG (SJTU *NIX User Group)" apac.sjtug
	docker exec director mirrorbits add -http http://mirror.lagoon.nc/pub/parrot -rsync rsync://mirror.lagoon.nc/parrot -comment "Lagoon" apac.lagoon
	docker exec director mirrorbits add -http https://mirrors.tuna.tsinghua.edu.cn/parrot -rsync rsync://mirrors.tuna.tsinghua.edu.cn/parrot -comment "TUNA (Tsinghua university of Beijing, TUNA association)" apac.tuna
	


director-enable:
	echo 1




reposync:
	docker exec -i updater rsync -PahvHtSxl --delay-updates --delete-after master.rsync.parrot.sh/parrot /var/www/repository/parrot


cleanlogs:


cleancache:


stats:
