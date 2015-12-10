# Openstack Compute Node Neutron Setup
class openstack::neutron::compute {
  ['ebtables', 'ipset'].each |String $pkg| {
    package {$pkg: ensure => latest }
  }
}
