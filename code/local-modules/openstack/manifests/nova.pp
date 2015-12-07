# Openstack Nova setup
class openstack::nova
inherits openstack::nova::params {
  include 'openstack::nova::credentials'
  class { '::nova':
    database_connection => $openstack::nova::params::db_url,
    rabbit_userid       => $openstack::nova::params::rabbit_user,
    rabbit_password     => $openstack::nova::params::rabbit_password,
  }
  class { '::nova::api':
    admin_user        => $openstack::nova::params::keystone_user,
    admin_password    => $openstack::nova::params::keystone_password,
    admin_tenant_name => 'service',
    auth_uri          => ['http://localhost:5000', 'http://localhost:35357'],
    enabled_apis      => 'osapi_compute,metadata',
  }
  class { '::nova::conductor':
    use_local      => true,
  }
  include ::nova::cert
  include ::nova::consoleauth
  include ::nova::scheduler
  class { '::nova::compute':
    vncserver_proxyclient_address => '\$my_ip',
  }
  include ::nova::compute::libvirt
  include ::nova::vncproxy

  class { '::nova::db::mysql':
    user     => $openstack::nova::params::db_user,
    password => $openstack::nova::params::db_password,
    dbname   => $openstack::nova::params::db_name,
    host     => 'localhost',
  }

  $openstack::nova::params::override_options.each
  |String $section, Hash $options| {
    $options.each |String $key, String $value| {
      nova_config { "${section}/${key}":
        ensure => present,
        value  => $value,
      }
    }
  }
}
