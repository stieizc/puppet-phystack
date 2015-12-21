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

  $config = '/etc/nova/nova.conf'

  $packages = [
    openstack-nova-api, openstack-nova-cert,
    openstack-nova-conductor, openstack-nova-console,
    openstack-nova-novncproxy, openstack-nova-scheduler,
    python-novaclient,
    openstack-nova-compute, sysfsutils
  ]

  $controller_services = [
    openstack-nova-api, openstack-nova-cert, openstack-nova-consoleauth,
    openstack-nova-scheduler, openstack-nova-conductor,
    openstack-nova-novncproxy
  ]

  $compute_services = [
    libvirtd, openstack-nova-compute
  ]
}
