# Nova Parameters
class openstack::nova::params {
  $db_user_data = hiera('database::accounts')['nova']
  $db_user = $db_user_data['user']
  $db_password = $db_user_data['password']
  $db_name = $db_user_data['db']
  $db_url = @("EOT"/L)
  mysql://${uriescape($db_user)}:${uriescape($db_password)}\
  @localhost/${uriescape($db_name)}\
  | EOT
  $keystone_user_data = hiera('keystone::accounts')['nova']
  $keystone_user = $keystone_user_data['user']
  $keystone_password = $keystone_user_data['password']
  $rabbit_user_data = hiera('mq::accounts')['common']
  $rabbit_user = $rabbit_user_data['name']
  $rabbit_password = $rabbit_user_data['password']

  $override_options = {
    'DEFAULT' => {
      my_ip                     => $::ipaddress,
      linuxnet_interface_driver =>
      'nova.network.linux_net.NeutronLinuxBridgeInterfaceDriver',
      auth_url                  => 'http://localhost:35357',
    },
    'vnc' => {
      enabled                       => 'True',
      vncserver_listen              => '0.0.0.0',
      novncproxy_base_url           => "http://${::ipaddress}:6080/vnc_auto.html",
    },
    'glance' => {
      host => 'localhost',
    },
  }
}
