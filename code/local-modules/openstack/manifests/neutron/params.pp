# Neutron Parameters
class openstack::neutron::params {
  $db_user_data = hiera('database::accounts')['neutron']
  $db_user = $db_user_data['user']
  $db_password = $db_user_data['password']
  $db_name = $db_user_data['db']
  $db_url = @("EOT"/L)
  mysql://${uriescape($db_user)}:${uriescape($db_password)}\
  @localhost/${uriescape($db_name)}\
  | EOT
  $keystone_user_data = hiera('keystone::accounts')['neutron']
  $keystone_user = $keystone_user_data['user']
  $keystone_password = $keystone_user_data['password']
  $rabbit_user_data = hiera('mq::accounts')['common']
  $rabbit_user = $rabbit_user_data['name']
  $rabbit_password = $rabbit_user_data['password']
  $metadata_shared_secret = hiera('neutron::metadata')['secret']

  $linux_bridge_config = hiera('neutron::ml2::linux_bridge')

  $packages = [
    openstack-neutron, openstack-neutron-ml2,
    openstack-neutron-linuxbridge, python-neutronclient,
    ebtables, ipset,
  ]

  $services = [
    neutron-server, neutron-linuxbridge-agent, neutron-dhcp-agent,
    neutron-metadata-agent,
    neutron-l3-agent
  ]
}
