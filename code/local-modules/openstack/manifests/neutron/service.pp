# Openstack Neutron Service

class openstack::neutron::service
inherits openstack::neutron::params {
  service { ['openstack-nova-api', 'openstack-nova-compute']:
    ensure    => running,
    enable    => true,
    subscribe => [
      Class[Openstack::Neutron::Install],
      Class[Openstack::Neutron::Config],
      Class[Openstack::Neutron::Db],
    ],
  }
  ~>
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

