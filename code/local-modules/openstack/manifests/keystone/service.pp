# Openstack Keystone Service

class openstack::keystone::service
inherits openstack::keystone::params {
  class { '::keystone::wsgi::apache':
    ssl       => false,
    subscribe => [
        Class[Openstack::Keystone::Install],
        Class[Openstack::Keystone::Config],
        Class[Openstack::Keystone::Db],
    ],
  }
}

