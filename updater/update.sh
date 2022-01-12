#!/bin/bash

SOURCE_PARROT="rsync://master.rsync.parrot.sh/parrot"
TARGET_PARROT=/var/www/repository/parrot
SOURCE_ALL="rsync://master.rsync.parrot.sh/internal"
TARGET_ALL=/var/www/repository

D1DEB="rsync://mirrors.dotsrc.org/devuan"
D1ISO="rsync://mirror.leaseweb.net/devuan"
TARGET="/var/www/repository"

#init
mkdir -p $TARGET_PARROT
mkdir -p $TARGET/devuan
rm $TARGET_PARROT/SYNC_IN_PROGRESS.* || true
rm $TARGET_ALL/SYNC_IN_PROGRESS.* || true

# update parrot repository
#while true; do
#	mkdir -p $TARGET_PARROT
#	#flock -xn /tmp/parrot-rsync.lock -c "rsync -PahvHtSx --delay-updates --delete-after master.rsync.parrot.sh/parrot /var/www/repository/parrot"
#	touch $TARGET_PARROT/SYNC_IN_PROGRESS.lock || true
#	flock -xn $TARGET_PARROT/SYNC_IN_PROGRESS.pool.lock -c "rsync -qaHtSx --preallocate --safe-links --exclude=dists --exclude=iso $SOURCE_PARROT $TARGET_PARROT/"
#	flock -xn $TARGET_PARROT/SYNC_IN_PROGRESS.dists.lock -c "rsync -qaHtSx --preallocate --safe-links --exclude=iso --delay-updates --delete-after $SOURCE_PARROT $TARGET_PARROT/"
#	flock -xn $TARGET_PARROT/SYNC_IN_PROGRESS.iso.lock -c "rsync -qaHtSx --preallocate --safe-links --exclude=dists --exclude=pool --delay-updates --delete-after $SOURCE_PARROT $TARGET_PARROT/"
#	rm $TARGET_PARROT/SYNC_IN_PROGRESS.* || true
#	sleep 600
#done &

# if the parrot repository is not being update, then sync the whole internal archive
# otherwise wait 100 seconds and retry
#while true; do
#	mkdir -p $TARGET_ALL
#	while [ ! -f $TARGET_PARROT/SYNC_IN_PROGRESS.lock ];
#		do
#		flock -xn $TARGET_ALL/SYNC_IN_PROGRESS.lock -c "rsync -qaHtSxl --safe-links --delete $SOURCE_ALL $TARGET_ALL/"
#		rm $TARGET_ALL/SYNC_IN_PROGRESS.* || true
#		sleep 43200
#	done
#	sleep 100
#done &

#while true; do
#	touch $TARGET/devuan/SYNC_IN_PROGRESS.lock || true
#	flock -xn $TARGET/devuan/SYNC_IN_PROGRESS.pool.lock -c "rsync -qaHtSx --preallocate --safe-links --delete-after $D1DEB/devuan/pool/ $TARGET/devuan/pool/"
#	flock -xn $TARGET/devuan/SYNC_IN_PROGRESS.dists.lock -c "rsync -qaHtSx --preallocate --safe-links --delay-updates --delete-after $D1DEB/devuan/dists/ $TARGET/devuan/dists/"
#	flock -xn $TARGET/devuan/SYNC_IN_PROGRESS.merged.lock -c "rsync -qaHtSx --preallocate --safe-links --delay-updates --delete-after $D1DEB/merged/ $TARGET/merged/"
#	flock -xn $TARGET/devuan/SYNC_IN_PROGRESS.iso.lock -c "rsync -qaHtSx --preallocate --safe-links --delay-updates --delete-after $D1ISO/ $TARGET/devuan/iso/"
#	rm $TARGET/devuan/SYNC_IN_PROGRESS.* || true
#	sleep 600
#done
