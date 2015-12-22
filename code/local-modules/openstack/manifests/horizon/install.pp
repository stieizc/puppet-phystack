# Openstack Horizon installation

class openstack::horizon::install
inherits openstack::horizon::params {
  package { $openstack::horizon::params::packages:
    ensure => latest,
  }
}

