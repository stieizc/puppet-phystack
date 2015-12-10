# Openstack Neutron Credentials Setup
class openstack::neutron::credentials
inherits openstack::neutron::params {
  class { '::neutron::keystone::auth':
    auth_name           => $openstack::neutron::params::keystone_user,
    password            => $openstack::neutron::params::keystone_password,
    service_name        => 'neutron',
    service_description => 'OpenStack Network Service',
    tenant              => 'service',
    public_url          => 'http://localhost:9696',
    internal_url        => 'http://localhost:9696',
    admin_url           => 'http://localhost:9696',
  }
}
