default['surfspots']['user'] = 'web_admin'
default['surfspots']['group'] = 'web_admin'

default['surfspots']['document_root'] = '/var/www/spots/public_html'

default['surfspots']['enabled_firewall_rules'] = %w(firewall_http firewall_sshd)

default['surfspots']['passwords']['secret_path'] = '/etc/chef/encrypted_data_bag_secret'

default['surfspots']['database']['dbname'] = 'spots'
default['surfspots']['database']['host'] = '127.0.0.1'
default['surfspots']['database']['username'] = 'root'

default['surfspots']['database']['app']['username'] = 'db_admin'

default['surfspots']['database']['seed_file'] ='/tmp/create-tables.sql'