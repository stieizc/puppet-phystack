# Keystone Parameters
class openstack::keystone::params {
  $db_user_data = hiera('database::accounts')['keystone']
  $db_user = $db_user_data['user']
  $db_password = $db_user_data['password']
  $db_name = $db_user_data['db']
  $db_url = @("EOT"/L)
  mysql://${uriescape($db_user)}:${uriescape($db_password)}\
  @localhost/${uriescape($db_name)}\
  | EOT
  $admin_token = hiera('keystone::admin_token')
  $packages = [openstack-keystone]
}
