name             'provision'
maintainer       'devops'
maintainer_email 'ave.dmitriev@gmail.com'
license          'All rights reserved'
description      'Installs/Configures Nginx + php-fpm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

supports 'Ubuntu', '>= 14.04.3'

version          '1.0.0'

depends          'nginx', '~> 2.7.6'
depends          'php-fpm', '~> 0.7.5'