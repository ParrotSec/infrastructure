#!/bin/bash

while true; do
    (
        rsync -qa --delete-after rsync.parrot.sh:website /var/www/html || \
        rsync -qa --delete-after repository-2.internal.parrot.sh:website /var/www/html || \
        rsync -qa --delete-after repository-3.internal.parrot.sh:website /var/www/html
    )

    (
        rsync -qa --delete-after rsync.parrot.sh:docs /var/www/docs || \
        rsync -qa --delete-after repository-2.internal.parrot.sh:docs /var/www/docs || \
        rsync -qa --delete-after repository-3.internal.parrot.sh:docs /var/www/docs
    ) && rsync -qa --delete-after /var/www/docs/ /var/www/html/docs/

    sleep 600
done
