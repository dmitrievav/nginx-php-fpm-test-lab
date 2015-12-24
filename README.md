Nginx + php-fpm test environment
================================

It is a self-configurable Vagrant box for a development web server.  
All setup and provisioning are done via well-known automation Chef.  
Provisioning includes the following tasks:
- scanning of a shared vagrant directory (shared/) structure to get project list and settings (provision.json in each project directory)
- configuration of nginx virtual hosts with the data from projects' settings
- setting up hosts file with project's hostname

Deploy test environment
-----------------------

- Clone project `git clone https://github.com/dmitrievav/nginx-php-fpm-test-lab.git`
- Change current work directory `cd nginx-php-fpm-test-lab`
- Run `vagrant up`
- Run `ruby ./HostsUpdate.rb`

Tests and Demo
--------------

- [Open test web site](http://web-site-name1.dev)
- Try `curl  -i -H 'Host: web-site-name1.dev' #{vbox_ip}`
- [Watch demo](https://asciinema.org/a/32408)

Prerequisites
-------------

### Supported OS

- Mac OS as Host system
- Any Linux as VM (tested on Ubuntu 14.04)

### Install and customize VirtualBox

- [Download virtualbox](https://www.virtualbox.org/wiki/Downloads)
- create host-only network vboxnet0 10.0.0.0/24
- set the route: `sudo route add 10.0.0.0/24 -interface vboxnet0`

### Install Vagrant

- [Download Vagrant](https://www.vagrantup.com/downloads.html)
- Install vagrant-berkshelf plugin
- Install vagrant-omnibus plugin

Content description
-------------------

- shared/*: www projects
- shared/*/provision.json: project's settings
- Vagrantfile: vbox initial settings
- chef/cookbooks/*: Auxiliary community cookbooks
- chef/cookbooks/provision: Chef cookbook that installs and costomizes Nginx + php-fpm [more details](chef/cookbooks/provision/README.html)
- HostsUpdate.rb: Updates /etc/hosts file on host system

