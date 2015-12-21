# Openstack Nova setup
class openstack::nova
inherits openstack::nova::params {
  class { 'openstack::nova::install': }
  ->
  class { 'openstack::nova::config': }
  ->
  class { 'openstack::nova::db': }
  ->
  class { 'openstack::nova::service': }
  ->
  class { 'openstack::nova::credentials': }
}
