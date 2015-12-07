# Openstack Glance Credentials Setup
class openstack::glance::credentials
inherits openstack::glance::params {
  class { '::glance::keystone::auth':
    auth_name           => $openstack::glance::params::keystone_user,
    password            => $openstack::glance::params::keystone_password,
    service_name        => 'glance',
    service_description => 'OpenStack Image Service',
    tenant              => 'service',
    public_url          => 'http://localhost:9292',
    internal_url        => 'http://localhost:9292',
    admin_url           => 'http://localhost:9292',
  }
}
