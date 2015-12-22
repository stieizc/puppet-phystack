# Openstack Neutron Setup
class openstack::neutron
inherits openstack::neutron::params {

  include openstack::neutron::ml2
  include openstack::neutron::l3
  include openstack::neutron::compute
}
