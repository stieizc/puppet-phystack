# Neutron add networks
class openstack::neutron::networks {
  $public_net = 'public-net'
  $public_net_physical = 'public'
  $public_nat_subnet = 'public-nat-subnet'

  $demo_net = 'demo-net'
  $demo_subnet = 'demo-subnet'

  $ext_router = 'ext-router'

  neutron_network { $public_net:
    ensure                    => present,
    tenant_name               => 'admin',
    shared                    => true,
    provider_physical_network => $public_net_physical,
    provider_network_type     => 'flat',
    router_external           => true,
  }
  ->
  neutron_subnet { $public_nat_subnet:
    ensure           => present,
    tenant_name      => 'admin',
    network_name     => $public_net,
    cidr             => '121.194.167.0/24',
    allocation_pools => [
        'start=121.194.167.81,end=121.194.167.81',
    ],
    ip_version       => '4',
    enable_dhcp      => false,
    gateway_ip       => '121.194.167.254',
  }
  ->
  neutron_network { $demo_net:
    ensure                => present,
    tenant_name           => 'demo',
    shared                => false,
    provider_network_type => 'vxlan',
  }
  ->
  neutron_subnet { $demo_subnet:
    ensure          => present,
    tenant_name     => 'demo',
    network_name    => $demo_net,
    cidr            => '192.168.0.0/24',
    ip_version      => '4',
    enable_dhcp     => true,
    gateway_ip      => '192.168.0.1',
    dns_nameservers => ['223.5.5.5'],
  }
  ->
  neutron_router { $ext_router:
    ensure               => present,
    tenant_name          => 'admin',
    gateway_network_name => $public_net,
  }
  ->
  neutron_router_interface { "${ext_router}:${demo_subnet}":
    ensure => present,
  }
}
