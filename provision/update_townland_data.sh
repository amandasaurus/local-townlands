#! /bin/bash

export PATH=/usr/local/bin:$PATH

set -o errexit
set -o nounset

cd /vagrant

cd djangoproject
eval `python manage.py envdbsettings`
cd ..

nice -n 10 /vagrant/osm-irish-townlands/import_townlands.sh $TOWNLANDS_DB_USER $TOWNLANDS_DB_PASS ./static/downloads/

cd djangoproject
nice -n 10 python manage.py importtownlands
python manage.py importosmhistory ~/osm-irish-townlands/ieadmins-sample.csv


# clean up after
#PGPASSWORD=${TOWNLANDS_DB_PASS} PGOPTIONS="--client-min-messages=warning" psql -q -U ${TOWNLANDS_DB_USER} -d gis -c "drop table if exists valid_polygon;"
#PGPASSWORD=${TOWNLANDS_DB_PASS} PGOPTIONS="--client-min-messages=warning" psql -q -U ${TOWNLANDS_DB_USER} -d gis -c "drop table if exists water_polygon;"
cd ..

