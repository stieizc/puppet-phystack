# Openstack Neutron Metadata Agent Setup
class openstack::neutron::metadata
inherits openstack::neutron::params {
  class { '::neutron::agents::metadata':
    auth_user     => $openstack::neutron::params::keystone_user,
    auth_password => $openstack::neutron::params::keystone_password,
    auth_tenant   => 'service',
    auth_url      => 'http://localhost:35357',
    shared_secret => $openstack::neutron::params::metadata_shared_secret,
  }
  neutron_metadata_agent_config {
    'DEFAULT/auth_uri': value => 'http://localhost:5000',
  }
}
