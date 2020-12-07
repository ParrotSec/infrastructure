include .env
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
	$(D) $(EDGE) down --remove-orphans

edge-update:
	git pull
	$(D) $(EDGE) pull
	$(D) $(EDGE) build
	$(D) $(EDGE) up -d --remove-orphans

edge-start:
	$(D) $(EDGE) pull
	$(D) $(EDGE) build
	$(D) $(EDGE) up -d --remove-orphans

edge-ps:
	$(D) $(EDGE) ps

edge-logs:
	$(D) $(EDGE) logs

edge: edge-stop edge-update edge-start




gibson-stop:
	$(D) $(GIBSON) down --remove-orphans

gibson-update:
	git pull
	$(D) $(GIBSON) pull
	$(D) $(GIBSON) build
	$(D) $(GIBSON) up -d --remove-orphans

gibson-start:
	$(D) $(GIBSON) pull
	$(D) $(GIBSON) build
	$(D) $(GIBSON) up -d --remove-orphans

gibson-ps:
	$(D) $(GIBSON) ps

gibson-logs:
	$(D) $(GIBSON) logs

gibson: gibson-stop gibson-update




mirror-stop:
	$(D) $(MIRROR) down --remove-orphans

mirror-update:
	git pull
	$(D) $(MIRROR) pull
	$(D) $(MIRROR) build
	$(D) $(MIRROR) up -d --remove-orphans

mirror-start:
	$(D) $(MIRROR) pull
	$(D) $(MIRROR) build
	$(D) $(MIRROR) up -d --remove-orphans

mirror-ps:
	$(D) $(MIRROR) ps

mirror-logs:
	$(D) $(MIRROR) logs

mirror: mirror-stop mirror-update mirror-start



central-stop:
	$(D) $(CENTRAL) down --remove-orphans

central-update:
	git pull
	$(D) $(CENTRAL) pull
	$(D) $(CENTRAL) build
	$(D) $(CENTRAL) up -d --remove-orphans

central-start:
	$(D) $(CENTRAL) pull
	$(D) $(CENTRAL) build
	$(D) $(CENTRAL) up -d --remove-orphans

central-ps:
	$(D) $(CENTRAL) ps

central: central-stop central-update central-start

director-feed:
	docker exec director mirrorbits add -http https://mirrors.mit.edu/parrot -rsync rsync://mirrors.mit.edu/parrot -comment "SIPB MIT (1Gbps)" ncsa.mit
	docker exec director mirrorbits add -http https://mirror.clarkson.edu/parrot -rsync rsync://mirror.clarkson.edu/parrot -comment "Clarkson University" ncsa.clarkson
	docker exec director mirrorbits add -http https://ftp.osuosl.org/pub/parrotos -rsync rsync://ftp.osuosl.org/parrotos -comment "Oregon State University - Open Source Lab" ncsa.osuosl
	docker exec director mirrorbits add -http https://mirrors.ocf.berkeley.edu/parrot -rsync rsync://mirrors.ocf.berkeley.edu/parrot -comment "Berkeley Open Computing Facility" ncsa.berkeley
	docker exec director mirrorbits add -http https://muug.ca/mirror/parrot -rsync rsync://muug.ca/parrot -comment "Manitoba Unix User Group" ncsa.muug
	docker exec director mirrorbits add -http https://mirror.cedia.org.ec/parrot -rsync rsync://mirror.cedia.org.ec/parrot -comment "RED CEDIA (National research and education center of Ecuador)" ncsa.cedia
	docker exec director mirrorbits add -http https://mirror.uta.edu.ec/parrot -rsync rsync://mirror.uta.edu.ec/parrot -comment "UTA (Universidad Técnica de ambato)" ncsa.uta
	docker exec director mirrorbits add -http http://mirror.ueb.edu.ec/parrot -rsync rsync://mirror.ueb.edu.ec/parrot -comment "UEB (Universidad Estatal de Bolivar)" ncsa.ueb
	docker exec director mirrorbits add -http http://sft.if.usp.br/parrot -rsync rsync://sft.if.usp.br/parrot -comment "University of Sao Paulo" ncsa.usp
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
	docker exec director mirrorbits add -http https://parrot.mirror.cythin.com/parrot -rsync rsync://parrot.mirror.cythin.com/parrot -comment "cythin.com" emea.cythin
	docker exec director mirrorbits add -http https://quantum-mirror.hu/mirrors/pub/parrot -rsync rsync://quantum-mirror.hu/mirrors/pub/parrot/ -comment "quantum-mirror.hu" emea.quantum
	docker exec director mirrorbits add -http https://mirror.yandex.ru/mirrors/parrot -rsync rsync://mirror.yandex.ru/mirrors/parrot/ -comment "Yandex Mirror" apac.yandex
	docker exec director mirrorbits add -http http://mirror.truenetwork.ru/parrot -rsync rsync://mirror.truenetwork.ru/parrot -comment "Truenetwork" apac.truenetwork
	docker exec director mirrorbits add -http http://mirrors.comsys.kpi.ua/parrot -rsync rsync://mirrors.comsys.kpi.ua/parrot-iso -comment "KPI (National Technical University of Ukraine - Comsys)" emea.comsys
	docker exec director mirrorbits add -http http://mirror.amberit.com.bd/parrotsec -rsync rsync://mirror.amberit.com.bd/parrotsec -comment "Amberit (Dhakacom)" apac.amberit
	docker exec director mirrorbits add -http https://free.nchc.org.tw/parrot -ftp ftp://free.nchc.org.tw/parrot/ -comment "NCHC (Free Software Lab)" apac.nchc
	docker exec director mirrorbits add -http https://mirror.0x.sg/parrot -rsync rsync://mirror.0x.sg/parrot -comment "0x" apac.0x
	docker exec director mirrorbits add -http https://mirrors.ustc.edu.cn/parrot -rsync rsync://mirrors.ustc.edu.cn/repo/parrot/ -comment "University of Science and Technology of China and USTCLUG" apac.ustc
	docker exec director mirrorbits add -http https://mirror.kku.ac.th/parrot -rsync rsync://mirror.kku.ac.th/parrot -comment "KKU (Khon Kaen University)" apac.kku
	docker exec director mirrorbits add -http http://kartolo.sby.datautama.net.id/parrot -rsync rsync://kartolo.sby.datautama.net.id/parrot -comment "Datautama (PT. Data Utama Dinamika)" apac.datautama
	docker exec director mirrorbits add -http https://mirrors.takeshi.nz/parrot -rsync rsync://mirrors.takeshi.nz/parrot -comment "Takeshi (D T Consulting Ltd)" apac.takeshi
	docker exec director mirrorbits add -http http://mirrors.shu.edu.cn/parrot -rsync rsync://mirrors.shu.edu.cn/parrot -comment "SHU(Shanghai University)" apac.shu
	docker exec director mirrorbits add -http http://mirrors.sjtug.sjtu.edu.cn/parrot -rsync rsync://mirrors.sjtug.sjtu.edu.cn/parrot -comment "SJTUG (SJTU *NIX User Group)" apac.sjtug
	docker exec director mirrorbits add -http http://mirror.lagoon.nc/pub/parrot -rsync rsync://mirror.lagoon.nc/parrot -comment "Lagoon" apac.lagoon
	docker exec director mirrorbits add -http https://mirrors.tuna.tsinghua.edu.cn/parrot -rsync rsync://mirrors.tuna.tsinghua.edu.cn/parrot -comment "TUNA (Tsinghua university of Beijing, TUNA association)" apac.tuna
	docker exec director mirrorbits add -http https://us1-ncsa-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.us1
	docker exec director mirrorbits add -http https://us2-ncsa-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.us2
	docker exec director mirrorbits add -http https://us3-ncsa-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.us3
	docker exec director mirrorbits add -http https://latam1-ncsa-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.latam1
	docker exec director mirrorbits add -http https://latam2-ncsa-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.latam2
	docker exec director mirrorbits add -http https://latam3-ncsa-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.latam3
	docker exec director mirrorbits add -http https://euro1-emea-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.euro1
	docker exec director mirrorbits add -http https://euro2-emea-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.euro2
	docker exec director mirrorbits add -http https://euro3-emea-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.euro3
	docker exec director mirrorbits add -http https://africa1-emea-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.africa1
	docker exec director mirrorbits add -http https://africa2-emea-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.africa2
	docker exec director mirrorbits add -http https://africa3-emea-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.africa3
	docker exec director mirrorbits add -http https://africa4-emea-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.africa4
	docker exec director mirrorbits add -http https://meast1-emea-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.meast1
	docker exec director mirrorbits add -http https://meast2-emea-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.meast2
	docker exec director mirrorbits add -http https://india1-apac-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.india1
	docker exec director mirrorbits add -http https://china1-apac-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.china1
	docker exec director mirrorbits add -http https://pacific1-apac-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.pacific1
	docker exec director mirrorbits add -http https://pacific2-apac-mirror.parrot.sh/mirrors/parrot -rsync rsync://rsync.parrot.sh/parrot -comment "Parrot OS CDN" parrot.pacific2


director-enable:
	docker exec director mirrorbits enable ncsa.mit
	docker exec director mirrorbits enable ncsa.clarkson
	docker exec director mirrorbits enable ncsa.osuosl
	docker exec director mirrorbits enable ncsa.berkeley
	docker exec director mirrorbits enable ncsa.muug
	docker exec director mirrorbits enable ncsa.cedia
	docker exec director mirrorbits enable ncsa.uta
	docker exec director mirrorbits enable ncsa.ueb
	docker exec director mirrorbits enable ncsa.usp
	docker exec director mirrorbits enable emea.garr
	docker exec director mirrorbits enable emea.halifax
	docker exec director mirrorbits enable emea.esslingen
	docker exec director mirrorbits enable emea.nluug
	docker exec director mirrorbits enable emea.umu
	docker exec director mirrorbits enable emea.uoc
	docker exec director mirrorbits enable emea.belnet
	docker exec director mirrorbits enable emea.osluz
	docker exec director mirrorbits enable emea.up
	docker exec director mirrorbits enable emea.dotsrc
	docker exec director mirrorbits enable emea.cythin
	docker exec director mirrorbits enable emea.quantum
	docker exec director mirrorbits enable apac.yandex
	docker exec director mirrorbits enable apac.truenetwork
	docker exec director mirrorbits enable emea.comsys
	docker exec director mirrorbits enable apac.amberit
	docker exec director mirrorbits enable apac.nchc
	docker exec director mirrorbits enable apac.0x
	docker exec director mirrorbits enable apac.ustc
	docker exec director mirrorbits enable apac.kku
	docker exec director mirrorbits enable apac.datautama
	docker exec director mirrorbits enable apac.takeshi
	docker exec director mirrorbits enable apac.shu
	docker exec director mirrorbits enable apac.sjtug
	docker exec director mirrorbits enable apac.lagoon
	docker exec director mirrorbits enable apac.tuna
	docker exec director mirrorbits enable parrot.us1
	docker exec director mirrorbits enable parrot.us2
	docker exec director mirrorbits enable parrot.us3
	docker exec director mirrorbits enable parrot.latam1
	docker exec director mirrorbits enable parrot.latam2
	docker exec director mirrorbits enable parrot.latam3
	docker exec director mirrorbits enable parrot.euro1
	docker exec director mirrorbits enable parrot.euro2
	docker exec director mirrorbits enable parrot.euro3
	docker exec director mirrorbits enable parrot.meast1
	docker exec director mirrorbits enable parrot.meast2
	docker exec director mirrorbits enable parrot.africa1
	docker exec director mirrorbits enable parrot.africa2
	docker exec director mirrorbits enable parrot.africa3
	docker exec director mirrorbits enable parrot.africa4
	docker exec director mirrorbits enable parrot.india1
	docker exec director mirrorbits enable parrot.china1
	docker exec director mirrorbits enable parrot.pacific1
	docker exec director mirrorbits enable parrot.pacific2




reposync:
	docker exec -i updater rsync -PahvHtSxl --delay-updates --delete-after master.rsync.parrot.sh/parrot /var/www/repository/parrot


cleanlogs:


cleancache:


stats:
