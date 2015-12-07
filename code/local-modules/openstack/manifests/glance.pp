# Openstack Glance Setup
class openstack::glance
inherits openstack::glance::params {
  include 'openstack::glance::credentials'

  class { '::glance::api':
    keystone_user       => $openstack::glance::params::keystone_user,
    keystone_password   => $openstack::glance::params::keystone_password,
    keystone_tenant     => 'service',
    database_connection => $openstack::glance::params::db_url,
    auth_uri            => ['http://localhost:5000', 'http://localhost:35357'],
  }

  glance_api_config { 'DEFAULT/notification_driver':
    ensure => 'present',
    value  => 'noop',
  }

  class { '::glance::registry':
    bind_host           => 'localhost',
    keystone_user       => $openstack::glance::params::keystone_user,
    keystone_password   => $openstack::glance::params::keystone_password,
    keystone_tenant     => 'service',
    database_connection => $openstack::glance::params::db_url,
    auth_uri            => ['http://localhost:5000', 'http://localhost:35357'],
  }

  glance_registry_config { 'DEFAULT/notification_driver':
    ensure => 'present',
    value  => 'noop',
  }

  class { '::glance::backend::file': }

  class { '::glance::db::mysql':
    user     => $openstack::glance::params::db_user,
    password => $openstack::glance::params::db_password,
    dbname   => $openstack::glance::params::db_name,
    host     => 'localhost',
  }
}
