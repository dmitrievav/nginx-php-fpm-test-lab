
#<> DNS suffix
default[:dns_suffix] = ".dev"


# scan shared folder for projects
projects = []
Dir.glob("/vagrant/shared/*/provision.json").each { |x|
  json = JSON.parse(IO.read(x))
  projects << { project_name: json['project_name'], root: File.expand_path("..", x)}
}
#<> Projects from shared/*/provision.json
default[:projects] = projects