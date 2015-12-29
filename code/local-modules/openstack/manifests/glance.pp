# Openstack Glance Setup
class openstack::glance
inherits openstack::glance::params {
  class { 'openstack::glance::install': }
  ->
  class { 'openstack::glance::config': }
  ->
  class { 'openstack::glance::db': }
  ->
  class { 'openstack::glance::credentials': }
  ->
  class { 'openstack::glance::service': }
}
