# Openstack Neutron DHCP Agent Setup
class openstack::neutron::dhcp {
  $dnsmasq_config_file = '/etc/neutron/dnsmasq-neutron.conf'
  class { '::neutron::agents::l3':
    interface_driver         =>
    'neutron.agent.linux.interface.BridgeInterfaceDriver',
    dhcp_driver              => 'neutron.agent.linux.dhcp.Dnsmasq',
    enable_isolated_metadata => true,
    dnsmasq_config_file      => $dnsmasq_config_file,
  }

  file_line { 'DHCP MTU Setup':
    path => $dnsmasq_config_file,
    line => 'dhcp-option-force=26,1450',
  }
}
