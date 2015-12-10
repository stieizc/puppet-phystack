# Openstack Keystone setup

class openstack::keystone
inherits openstack::keystone::params {
  class { '::memcached': }
  ->
  class { '::keystone':
    database_connection => $openstack::keystone::params::db_url,
    admin_token         => $openstack::keystone::params::admin_token,
    token_provider      => 'uuid',
    token_driver        => 'memcache',
    memcache_servers    => ['localhost:11211'],
    revoke_driver       => 'sql',
    service_name        => 'httpd',
  }

  class { '::keystone::db::mysql':
    user     => $openstack::keystone::params::db_user,
    password => $openstack::keystone::params::db_password,
    dbname   => $openstack::keystone::params::db_name,
  }

  class { '::keystone::wsgi::apache':
    servername => $::ipaddress,
    ssl        => false,
  }

  include 'openstack::keystone::credentials'
}
