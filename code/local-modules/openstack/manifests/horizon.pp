# Openstack Horizon Setup
class openstack::horizon
inherits openstack::horizon::params {
  class { 'openstack::horizon::install': }
  ->
  class { 'openstack::horizon::config': }
  ->
  class { 'openstack::horizon::service': }
}
