Developement environment for osm-irish-townlands. This will create something that's similar to www.townlands.ie

# Installation

 * Install [vagrant](https://www.vagrantup.com/downloads.html).
 * Clone this repository
 * Run `vagrant up --provision`. After it's done, you'll have an empty townlands.ie site on http://localhost:18000/

# Updating data

Run `vagrant ssh -c '/vagrant/provision/update_townland_data.sh'`. It will take ~30 -> 60 minutes to finish. It will download the latest Ireland extract from plant.openstreetmap.ie. You can do this as often as you want, but you don't need to do it more than one. It's totally possible to keep working with old data for months.

# Get hacking!

Edit the code in ./osm-irish-townlands. Changes will appear after a few seconds on your web browser.
