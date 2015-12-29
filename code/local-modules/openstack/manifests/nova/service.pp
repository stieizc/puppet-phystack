# Openstack Nova Service

class openstack::nova::service
inherits openstack::nova::params {
  service { [
    $openstack::nova::controller_services,
    $openstack::nova::compute_services,
  ]:
    ensure    => running,
    enable    => true,
    subscribe => [
      Class[Openstack::Nova::Install],
      Class[Openstack::Nova::Config],
      Class[Openstack::Nova::Db],
    ],
  }

  Service[$openstack::nova::controller_services]
  ->
  Service[$openstack::nova::compute_services]
  Service['libvirtd'] -> Service['openstack-nova-compute']
}

