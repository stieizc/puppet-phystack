# Openstack Keystone setup

class openstack::keystone {
  class { 'openstack::keystone::db': }
}
