odoo-vagrant
============

Vagrant Setup for Odoo

Dependencies
------------

* VirtualBox
* Vagrant 1.6.1

Setup
-----

1. Install virtualbox and vagrant

   ```
$ sudo apt-get install virtualbox vagrant

   ```

1. Clone this repository 

   ```
$ git clone git@github.com:dkubiak789/odoo-vagrant.git

   ```
1. Clone Odoo to sources/odoo

   ```
$ git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 --single-branch .
   ```
1. Vagrant up

   ```
$ cd odoo-vagrant
$ vagrant up
$ vagrant ssh
   ```
1. Run bootstrap.sh to install and configure Odoo

   ```
$ sudo chmod +x bootstrap.sh
$ ./bootstrap.sh
   ```
