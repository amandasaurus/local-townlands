#! /bin/bash -x

sudo apt-get update
sudo apt-get install --yes postgresql postgresql-9.1-postgis python-pip python-virtualenv postgresql-server-dev-9.1 python-dev

sudo -u postgres createuser -s townlands || true
sudo -u postgres createdb -O townlands townlands || true
sudo -u postgres psql -c "alter user townlands password 'townlands'"

cp /vagrant/django-server-upstart.conf /etc/init/django.conf

cd /vagrant

#virtualenv ~/virtualenv
#source ~/virtualenv/bin/activate

pip install --requirement /vagrant/python-requirements.txt
pip install -e /vagrant/osm-irish-townlands/

cd /vagrant/djangoproject

python manage.py syncdb
python manage.py migrate

start django
