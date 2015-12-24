=begin
#<
This recipe installs, customizes Nginx + php-fpm
and web sites from /vagrant/shared folder
#>
=end

include_recipe "nginx"
include_recipe "php-fpm"

directory "/var/www/shared" do
  recursive true
  action :create
  mode '0755'
end

mount '/var/www/shared' do
  device '/vagrant/shared'
  fstype "none"
  options "bind,ro"
  action [:mount, :enable]
end

php_fpm_pool "www" do
  process_manager "dynamic"
  max_requests 5000
  php_options 'php_admin_flag[log_errors]' => 'on', 'php_admin_value[memory_limit]' => '32M'
  listen_owner "vagrant"
  listen_group "vagrant"
  listen_mode "0600"
end

node[:projects].each { |x|
  nginx_site "#{x[:project_name]}#{node[:dns_suffix]}" do
    cookbook = "provision"
    template "nginx.vhost.conf.erb"
    variables({
      :project_name => "#{x[:project_name]}#{node[:dns_suffix]}",
      :root => x[:root].gsub(/vagrant/, 'var/www'),
      :dns_suffix => node[:dns_suffix]
    })
  end
}