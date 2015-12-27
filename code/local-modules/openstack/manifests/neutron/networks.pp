# Neutron add networks
class openstack::neutron::networks {
  neutron_network { 'public':
    shared                    => true,
    provider_physical_network => 'public',
    provider_network_type     => 'flat',
    router_external           => true,
  }
  ->
#  neutron_subnet { 'public':
#    network_name     => 'public',
#    cidr             => '121.194.167.80/32',
#    ip_version       => '4',
#    enable_dhcp      => false,
#    allocation_pools => [
#      'start=121.194.167.80,end=121.194.167.80'
#    ],
#    gateway_ip       => '121.194.167.254',
#    dns_nameservers  => ['233.5.5.5'],
#  }
#  ->
  neutron_network { 'private':
    tenant_name           => 'demo',
    shared                => false,
    #provider_network_type => 'vxlan',
  }
  ->
  neutron_subnet { 'private':
    network_name     => 'private',
    cidr             => '192.168.0.0/24',
    ip_version       => '4',
    enable_dhcp      => true,
    gateway_ip       => '192.168.0.1',
    dns_nameservers  => ['233.5.5.5'],
  }
  ->
  neutron_router { 'ext-router':
    gateway_network_name => 'public',
    tenant_name          => 'demo',
  }
  ->
  neutron_router_interface { 'ext-router:private':
    ensure => present,
  }
}
