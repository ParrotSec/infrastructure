#!/bin/bash

SOURCE_PARROT="rsync://master.rsync.parrot.sh/parrot"
TARGET_PARROT=/var/www/parrot
SOURCE_ALL="rsync://master.rsync.parrot.sh/internal"
TARGET_ALL=/var/www

while true; do
	#flock -xn /tmp/parrot-rsync.lock -c "rsync -PahvHtSx --delay-updates --delete-after master.rsync.parrot.sh/parrot /var/www/html/parrot"
	touch $TARGET_PARROT/SYNC_IN_PROGRESS.txt || true
	flock -xn $TARGET_PARROT/SYNC_IN_PROGRESS.pool.txt -c "rsync -qaHtSx --exclude=dists --exclude=iso $SOURCE_PARROT $TARGET_PARROT/"
	flock -xn $TARGET_PARROT/SYNC_IN_PROGRESS.dists.txt -c "rsync -qaHtSx --exclude=iso --delay-updates --delete-after $SOURCE_PARROT $TARGET_PARROT/"
	flock -xn $TARGET_PARROT/SYNC_IN_PROGRESS.iso.txt -c "rsync -qaHtSx --exclude=dists --exclude=pool --delay-updates $SOURCE_PARROT $TARGET_PARROT/"
	rm $TARGET_PARROT/SYNC_IN_PROGRESS.txt || true
	sleep 600
done &

while true; do
	flock -xn $TARGET_ALL/SYNC_IN_PROGRESS.txt -c "rsync -qaHtSx --exclude=parrot $SOURCE_PARROT $TARGET_PARROT/"
	sleep 3600
done
