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
    ssl=>false,
  }

  keystone_service { 'keystone':
    ensure      => present,
    type        => identity,
    description => 'OpenStack Identity',
  }

  keystone_endpoint { 'RegionOne/identity':
    ensure       => present,
    type         => identity,
    public_url   => 'http://localhost:5000/v2.0',
    internal_url => 'http://localhost:5000/v2.0',
    admin_url    => 'http://localhost:35357/v2.0',
  }
}
