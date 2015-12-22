# Openstack Neutron Setup
class openstack::neutron
inherits openstack::neutron::params {
  class { 'openstack::neutron::install': }
  ->
  class { 'openstack::neutron::config': }
  ->
  class { 'openstack::neutron::db': }
  ->
  class { 'openstack::neutron::credentials': }
  ->
  class { 'openstack::neutron::service': }
}
