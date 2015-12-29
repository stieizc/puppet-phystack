# Openstack Nova Credentials Setup
class openstack::nova::credentials
inherits openstack::nova::params {
  class { 'nova::keystone::auth':
    auth_name           => $openstack::nova::params::keystone_user,
    password            => $openstack::nova::params::keystone_password,
    service_name        => 'nova',
    service_description => 'OpenStack Compute Service',
    tenant              => 'service',
    public_url          => 'http://localhost:8774/v2/%(tenant_id)s',
    internal_url        => 'http://localhost:8774/v2/%(tenant_id)s',
    admin_url           => 'http://localhost:8774/v2/%(tenant_id)s',
  }
}
