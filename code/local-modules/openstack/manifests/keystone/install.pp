# Openstack Keystone installation

class openstack::keystone::install
inherits openstack::keystone::params {
  require '::memcached'

  include '::keystone::client'

  package { 'keystone':
    ensure => latest,
    name   => openstack-keystone,
  }
}

