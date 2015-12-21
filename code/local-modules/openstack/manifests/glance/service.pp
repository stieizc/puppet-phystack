# Openstack Glance Service

class openstack::glance::service
inherits openstack::glance::params {
  service { [openstack-glance-api, openstack-glance-registry]:
    ensure    => running,
    enable    => true,
    subscribe => [
      Class[Openstack::Glance::Install],
      Class[Openstack::Glance::Config],
      Class[Openstack::Glance::Db],
    ],
  }
}

