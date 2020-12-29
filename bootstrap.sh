#!/bin/sh

#sudo apt-get install -y language-pack-en
#sudo dpkg-reconfigure locales
#sudo update-locale LANG=en_US.UTF-8

sudo apt-get install -y language-pack-nl
sudo update-locale LANG=nl_NL.UTF-8
sudo dpkg-reconfigure locales

sudo apt-get update
sudo apt-get install -y git htop mc zsh
sudo curl -L http://install.ohmyz.sh | sh

# git global config
git config --global user.name "Dariusz Kubiak"
git config --global user.email dariusz.kubiak@ibood.com

# Install oh-my-zsh
git clone git://zsh.git.sf.net/gitroot
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
sudo chsh -s /bin/zsh

# copy ssh id from host
mkdir -p ~/.ssh
cp /vagrant/.ssh/id_rsa* ~/.ssh/
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

# Create the Odoo user that will own and run the application
sudo adduser --system --home=/opt/odoo --group odoo

# Install and configure the database server, PostgreSQL
sudo apt-get install -y postgresql
sudo pg_createcluster 9.3 main --start
sudo su - postgres -c "createuser --createdb --username postgres --no-createrole --no-superuser --no-password odoo"

# Install the necessary Python libraries for the server
sudo apt-get install -y python-cups python-dateutil python-decorator python-docutils python-feedparser \
    python-gdata python-geoip python-gevent python-imaging python-jinja2 python-ldap python-libxslt1 \
    python-lxml python-mako python-mock python-openid python-passlib python-psutil python-psycopg2 \
    python-pybabel python-pychart python-pydot python-pyparsing python-pypdf python-reportlab python-requests \
    python-simplejson python-tz python-unicodecsv python-unittest2 python-vatnumber python-vobject \
    python-werkzeug python-xlwt python-yaml wkhtmltopdf python-setuptools python-pip pep8 pylint

sudo pip install unidecode

SOURCES_PATH=$(pwd)/sources
echo "SOURCES_PATH=$SOURCES_PATH"

# Config file
sudo ln -sf /vagrant/odoo /opt/odoo/odoo
sudo ln -sf /vagrant/config/odoo-server.conf /etc/odoo-server.conf
sudo chown odoo: /etc/odoo-server.conf
sudo chmod 640 /etc/odoo-server.conf
ls -la /etc/odoo-server.conf


# Installing the boot script

sudo ln -sf /vagrant/config/odoo-server.init /etc/init.d/odoo-server
sudo chmod 755 /etc/init.d/odoo-server
sudo chown root: /etc/init.d/odoo-server
ls -la /etc/init.d/odoo-server

# Log file
sudo mkdir -p /var/log/odoo
sudo chown odoo:root /var/log/odoo
ls -la /var/log/odoo

# Automating Odoo startup and shutdown
sudo update-rc.d odoo-server defaults

# login as odoo
#su - odoo -s /bin/bash

echo "\ntail -f -n500 /var/log/odoo/odoo-server.log\n"
