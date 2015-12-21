# Openstack Glance installation

class openstack::glance::install
inherits openstack::glance::params {
  package { $openstack::glance::params::packages:
    ensure => latest,
  }
}

