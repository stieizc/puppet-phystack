# Openstack Glance Service

class openstack::glance::service
inherits openstack::glance::params {
  service { [openstack-glance-api, openstack-glance-registry]:
    ensure  => running,
    enabled => true,
  }
}

