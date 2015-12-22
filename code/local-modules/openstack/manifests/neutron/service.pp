# Openstack Neutron Service

class openstack::neutron::service
inherits openstack::neutron::params {
  ensure_resource(
    'service',
    ['openstack-nova-api', 'openstack-nova-compute'],
    {
      ensure    => running,
      enable    => true,
    }
  )

  service { $openstack::neutron::params::services:
    ensure    => running,
    enable    => true,
    subscribe => [
      Class[Openstack::Neutron::Install],
      Class[Openstack::Neutron::Config],
      Class[Openstack::Neutron::Db],
    ],
  }
}

