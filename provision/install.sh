#! /bin/bash -x

# Ensure our apt list of versions is up to dat
sudo apt-get update

# System packages we need
sudo apt-get install --yes postgresql postgis python-pip python-virtualenv postgresql-server-dev-9.3 python-dev osm2pgsql gdal-bin zip

# Database set up
sudo -u postgres createuser -s townlands || true
sudo -u postgres createdb -O townlands townlands || true
sudo -u postgres psql -c "alter user townlands password 'townlands';"
sudo -u postgres psql -d townlands -c "create extension postgis;"

# Upstart job for the dev server
cp /vagrant/provision/django-server-upstart.conf /etc/init/django.conf

cd /vagrant

# Python packages we need
# To fix https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1306991
easy_install pip 

# Install python packages
pip install --requirement /vagrant/provision/python-requirements.txt

# Local code. Notice the -e to make it 'editable'
pip install -e /vagrant/osm-irish-townlands/

cd /vagrant/djangoproject

# set up database
python manage.py syncdb
python manage.py migrate

# ensure it's running
restart django

# We don't need these running and they take up memory
sudo /etc/init.d/chef-client stop
sudo /etc/init.d/puppet stop

# make some swap space. better that it swaps than gets OOM killed
fallocate -l 5G /swap
mkswap /swap
swapon /swap
