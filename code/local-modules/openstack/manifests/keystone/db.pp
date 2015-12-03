# Keystone Database setup
class openstack::keystone::db
inherits openstack::keystone::params {
  mysql::db { $openstack::keystone::params::db_name:
    ensure   => 'present',
    user     => $openstack::keystone::params::db_user,
    password => $openstack::keystone::params::db_password,
  }
}
