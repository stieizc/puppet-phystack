# Openstack Keystone setup

class openstack::keystone
inherits openstack::keystone::params {
  class { 'openstack::keystone::install': }
  ->
  class { 'openstack::keystone::config': }
  ->
  class { 'openstack::keystone::db': }
  ->
  class { 'openstack::keystone::service': }
  ->
  class { 'openstack::keystone::credentials': }
}
