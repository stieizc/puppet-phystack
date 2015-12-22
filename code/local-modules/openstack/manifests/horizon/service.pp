# Openstack Horizon Service

class openstack::horizon::service
inherits openstack::horizon::params {
  ensure_resource(
    'service',
    [httpd, memcached],
    {
      ensure    => running,
      enable    => true,
    }
  )
}

