# Openstack Neutron Setup
class openstack::neutron
inherits openstack::neutron::params {
  include openstack::nova::params

  include openstack::neutron::credentials
  class { '::neutron':
    bind_host             => 'localhost',
    core_plugin           => 'ml2',
    service_plugins       => ['router'],
    allow_overlapping_ips => true,
    memcache_servers      => ['localhost:11211'],
    rabbit_user           => $openstack::neutron::params::rabbit_user,
    rabbit_password       => $openstack::neutron::params::rabbit_password,
  }
  class { '::neutron::server':
    auth_user           => $openstack::neutron::params::keystone_user,
    auth_password       => $openstack::neutron::params::keystone_password,
    auth_tenant         => 'service',
    auth_uri            => 'http://localhost:5000',
    database_connection => $openstack::neutron::params::db_url,
    sync_db             => true,
  }
  neutron_config { 'keystone_auth_token/auth_url': value => 'http://localhost:35357' }
  class { '::neutron::server::notifications':
    username     => $openstack::nova::params::keystone_user,
    password     => $openstack::nova::params::keystone_password,
    project_name => 'service',
    auth_url     => 'http://localhost:35357',
  }
  class { '::neutron::db::mysql':
    user     => $openstack::neutron::params::db_user,
    password => $openstack::neutron::params::db_password,
    dbname   => $openstack::neutron::params::db_name,
    host     => 'localhost',
  }

  include openstack::neutron::ml2
  include openstack::neutron::l3
  include openstack::neutron::compute
}
