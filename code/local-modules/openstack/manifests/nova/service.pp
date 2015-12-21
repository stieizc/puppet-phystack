# Openstack Nova Service

class openstack::nova::service
inherits openstack::nova::params {
  service { $openstack::nova::services:
    ensure => running,
    enable => true,
  }
}

