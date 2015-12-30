# Neutron add networks
class openstack::neutron::networks {
  neutron_network { 'public':
    ensure                    => present,
    tenant_name               => 'admin',
    shared                    => true,
    provider_physical_network => 'public',
    provider_network_type     => 'flat',
    router_external           => true,
  }
  ->
  neutron_network { 'demo-net':
    ensure                => present,
    tenant_name           => 'demo',
    shared                => false,
    provider_network_type => 'vxlan',
  }
  ->
  neutron_subnet { 'demo-subnet':
    ensure          => present,
    tenant_name     => 'demo',
    network_name    => 'demo-net',
    cidr            => '192.168.0.0/24',
    ip_version      => '4',
    enable_dhcp     => true,
    gateway_ip      => '192.168.0.1',
    dns_nameservers => ['233.5.5.5'],
  }
  ->
  neutron_router { 'ext-router':
    ensure                => present,
    tenant_name           => 'admin',
    gateway_network_name  => 'public',
    #external_gateway_info => {
    #  external_fixed_ips => $::ipaddress,
    #},
  }
  ->
  neutron_router_interface { 'ext-router:demo-subnet':
    ensure => present,
  }
}
