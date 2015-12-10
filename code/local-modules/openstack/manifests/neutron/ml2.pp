# Openstack Neutron ML2 Agent Setup
class openstack::neutron::ml2 {
  $ml2_config = hiera('neutron::ml2::linux_bridge')

  class { '::neutron::plugins::ml2':
    type_drivers         => [flat, vlan, vxlan],
    tenant_network_types => [vxlan],
    mechanism_drivers    => [linuxbridge,l2population],
    extension_drivers    => [port_security],
    flat_networks        => [public],
    vni_ranges           => '1:1000',
  }
  neutron_plugin_ml2 {
    'securitygroup/enable_ipset': value => true;
  }

  file { '/etc/neutron/plugins/linuxbridge':
    ensure => directory,
  }
  ->
  file { '/etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini':
    ensure => link,
    target => '/etc/neutron/plugins/ml2/linuxbridge_agent.ini',
  }
  ->
  Neutron_agent_linuxbridge <| |>

  class { '::neutron::agents::ml2::linuxbridge':
    tunnel_types                => ['vxlans'],
    local_ip                    => $::ipaddress,
    physical_interface_mappings => ["public:${ml2_config[public_int]}"],
    l2_population               => true,
  }

  neutron_agent_linuxbridge {
    'agent/prevent_arp_spoofing':
      value => true;
    'securitygroup/enable_security_group':
      value => true;
  }
}
