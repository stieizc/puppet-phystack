# Openstack Nova installation

class openstack::nova::install
inherits openstack::nova::params {
  package { $openstack::nova::params::packages:
    ensure => latest,
  }
}
