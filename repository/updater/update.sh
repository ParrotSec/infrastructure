#!/bin/bash

SOURCE_PARROT="rsync://master.rsync.parrot.sh/parrot"
TARGET_PARROT=/var/www/html/parrot
SOURCE_ALL="rsync://master.rsync.parrot.sh/internal"
TARGET_ALL=/var/www/html

#init
mkdir -p $TARGET_PARROT
rm $TARGET_PARROT/SYNC_IN_PROGRESS.* || true
rm $TARGET_ALL/SYNC_IN_PROGRESS.* || true


while true; do
	mkdir -p $TARGET_PARROT
	#flock -xn /tmp/parrot-rsync.lock -c "rsync -PahvHtSx --delay-updates --delete-after master.rsync.parrot.sh/parrot /var/www/html/parrot"
	touch $TARGET_PARROT/SYNC_IN_PROGRESS.lock || true
	flock -xn $TARGET_PARROT/SYNC_IN_PROGRESS.pool.lock -c "rsync -qaHtSx --exclude=dists --exclude=iso $SOURCE_PARROT $TARGET_PARROT/"
	flock -xn $TARGET_PARROT/SYNC_IN_PROGRESS.dists.lock -c "rsync -qaHtSx --exclude=iso --delay-updates --delete-after $SOURCE_PARROT $TARGET_PARROT/"
	flock -xn $TARGET_PARROT/SYNC_IN_PROGRESS.iso.lock -c "rsync -qaHtSx --exclude=dists --exclude=pool --delay-updates $SOURCE_PARROT $TARGET_PARROT/"
	rm $TARGET_PARROT/SYNC_IN_PROGRESS.* || true
	sleep 600
done &

while true; do
	mkdir -p $TARGET_ALL
	flock -xn $TARGET_ALL/SYNC_IN_PROGRESS.lock -c "rsync -qaHtSx --exclude=parrot $SOURCE_ALL $TARGET_ALL/"
	rm $TARGET_ALL/SYNC_IN_PROGRESS.* || true
	sleep 3600
done
