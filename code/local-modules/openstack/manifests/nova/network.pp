# Openstack Nova Network Setup
class openstack::nova::network {
  include openstack::neutron::params
  class { '::nova::network::neutron':
    neutron_url               => 'http://localhost:9696',

    neutron_admin_username    => $openstack::neutron::params::keystone_user,
    neutron_admin_password    => $openstack::neutron::params::keystone_password,
    neutron_admin_tenant_name => 'service',
    neutron_admin_auth_url    => 'http://localhost:35357',
  }
}
