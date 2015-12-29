# Openstack Neutron installation

class openstack::neutron::install
inherits openstack::neutron::params {
  package { $openstack::neutron::params::packages:
    ensure => latest,
  }
}

