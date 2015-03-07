#! /bin/bash

sudo apt-get update
sudo apt-get install postgresql postgresql-9.1-postgis

sudo -u postgres createuser -s vagrant || true
sudo -u postgres createdb -O vagrant vagrant || true
