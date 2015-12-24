# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "webserver" do |box01|
    box01.vm.box = "ubuntu/trusty64"
    #box01.vm.box_url = "...."
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    #config.cache.auto_detect = false
    #config.cache.enable :rpm
    #config.cache.enable :apt
    #config.cache.enable :gem
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    #config.proxy.http     = "http://10.0.0.254:8123/"
    #config.proxy.http     = "http://172.28.128.254:8123/"
    #config.proxy.no_proxy = "localhost,127.0.0.1"
  end

  if Vagrant.has_plugin? 'vagrant-omnibus'
    config.omnibus.chef_version = :latest
    # workaround for ruby-wmi
    #config.omnibus.chef_version = '11.12.8'
  end

  config.vm.network :private_network, type: "dhcp"
  #config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    vb.customize ["modifyvm", :id, "--hostonlyadapter2", "vboxnet0"]
  end

  ####### provision
  config.vm.provision :chef_zero do |chef|
    # Search perfectly works with "config.vm.provision :chef_zero", but in the same time "Chef::Config[:solo]" is somehow still true
    # Specify the local paths where Chef data is stored
    chef.cookbooks_path          = "chef/cookbooks"
    chef.roles_path              = "chef/roles"
    chef.environments_path       = "chef/environments"
    chef.data_bags_path          = "chef/data_bags"

    # Add a recipe
    chef.add_recipe "provision"
    # Or maybe a role
    #chef.add_role "web"
    # You may also specify custom JSON attributes:
    chef.json =  {
      'dns_suffix' => '.dev',
      'nginx' => {'user' => 'vagrant'}
    }
    #chef.environment = "ET"
    #chef.log_level = :debug
  end
  #######

end
