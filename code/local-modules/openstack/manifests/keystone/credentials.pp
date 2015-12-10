# Keystone credentials
class openstack::keystone::credentials {
  class { '::keystone::roles::admin':
    email          => hiera('email'),
    password       => hiera('keystone::accounts')['admin']['password'],
    admin_tenant   => 'admin',
    service_tenant => 'service',
  }

  keystone::resource::service_identity { 'keystone':
    service_name        => 'keystone',
    service_description => 'OpenStack Identity Service',
    service_type        => 'identity',
    configure_user      => false,
    configure_user_role => false,
    public_url          => 'http://localhost:5000/v2.0',
    internal_url        => 'http://localhost:5000/v2.0',
    admin_url           => 'http://localhost:35357/v2.0',
  }

  keystone_role { 'user':
    ensure => present,
  }
  ->
  keystone_tenant { 'demo':
    description => 'Demo Project',
  }
  ->
  keystone_user { 'demo':
    password    => hiera('keystone::accounts')['demo']['password'],
  }
  ->
  keystone_user_role { 'demo@demo':
    roles => ['user'],
  }
}
