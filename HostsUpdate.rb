#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'json'

# take vbox ip
# prerequisites: You have to create host-only network vboxnet0 10.0.0.0/24
ip = %x[vagrant ssh -c 'ifconfig | grep "inet " | egrep -v "127\.0\.0\.1|10\.0\.2\."' 2>/dev/null]
abort("Unable to get ip address. Make sure the box is running. Try `vagrant up` command") unless $?.success?
ip.gsub!(/.*inet addr:(.*?) .*/, '\1')
ip.chomp!
puts "ip: #{ip}"

# take dns_suffix
json = %x[vagrant ssh -c 'sudo cat /tmp/vagrant-chef/dna.json']
abort("Unable to get dns suffix. Make sure the box is running. Try `vagrant up` command") unless $?.success?
dns_suffix = (JSON.parse(json))['dns_suffix']
puts "dns_suffix: #{dns_suffix}"

# scan shared folder for project names
projects = []
Dir.glob("shared/*/provision.json").each { |x|
  json = JSON.parse(IO.read(x))
  projects << { project_name: json['project_name'], ip: ip}
}
hosts_patern = ".*\\d(\\s|\\t)(#{projects[0][:project_name]}#{dns_suffix}"
projects[1..-1].each { |x| hosts_patern += "|#{x[:project_name]}#{dns_suffix}"}
hosts_patern += ")$"
hosts_patern.gsub!(/\./,"\\.")
puts "hosts_patern: #{hosts_patern}"

# purge old hosts file entires
lines = File.read("/etc/hosts").split("\n")
lines.delete_if {|item| item =~ /#{hosts_patern}/ }

# update hosts file
projects.each { |x|
  lines << "#{ip}\t#{x[:project_name]}#{dns_suffix}"
}
File.open("/tmp/hosts", 'w') { |f| f.write(lines.join("\n")) }
puts "Updating /etc/hosts ..."
%x[sudo cp /etc/hosts /etc/hosts.bak && sudo sh -c 'cat /tmp/hosts > /etc/hosts' ]
abort("Unable to update hosts file. Make sure you have write permission for /etc/hosts") unless $?.success?