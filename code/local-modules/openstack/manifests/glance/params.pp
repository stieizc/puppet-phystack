# Glance Parameters
class openstack::glance::params {
  $db_user_data = hiera('database::accounts')['glance']
  $db_user = $db_user_data['user']
  $db_password = $db_user_data['password']
  $db_name = $db_user_data['db']
  $db_url = @("EOT"/L)
  mysql://${uriescape($db_user)}:${uriescape($db_password)}\
  @localhost/${uriescape($db_name)}\
  | EOT
  $keystone_user_data = hiera('keystone::accounts')['glance']
  $keystone_user = $keystone_user_data['user']
  $keystone_password = $keystone_user_data['password']
}
