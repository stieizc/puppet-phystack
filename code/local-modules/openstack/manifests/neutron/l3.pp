# Openstack Neutron L3 Agent Setup
class openstack::neutron::l3 {
  class { '::neutron::agents::l3':
    interface_driver        =>
    'neutron.agent.linux.interface.BridgeInterfaceDriver',
    external_network_bridge => '',
  }
}
