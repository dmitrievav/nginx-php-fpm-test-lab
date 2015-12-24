# Description

Installs/Configures Nginx + php-fpm

# Requirements

## Platform:

* Ubuntu (>= 14.04.3)

## Cookbooks:

* nginx (~> 2.7.6)
* php-fpm (~> 0.7.5)

# Attributes

* `node[:dns_suffix]` - DNS suffix. Defaults to `.dev`.
* `node[:projects]` - Projects from shared/*/provision.json. Defaults to `projects`.

# Recipes

* [provision::default](#provisiondefault)

## provision::default

This recipe installs, customizes Nginx + php-fpm
and web sites from /vagrant/shared folder

# License and Maintainer

Maintainer:: devops (<ave.dmitriev@gmail.com>)

License:: All rights reserved
