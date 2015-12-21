# Openstack Keystone database

class openstack::keystone::db
inherits openstack::keystone::params {
  class { '::keystone::db::mysql':
    user     => $openstack::keystone::params::db_user,
    password => $openstack::keystone::params::db_password,
    dbname   => $openstack::keystone::params::db_name,
  }

  exec { 'keystone-manage db_sync':
    command     => "keystone-manage db_sync",
    path        => '/usr/bin',
    user        => 'keystone',
    refreshonly => true,
    require     => User['keystone'],
    subscribe   => [
        Class[Openstack::Keystone::Install],
        Class[Openstack::Keystone::Config],
        Class[::Keystone::Db::Mysql],
    ],
  }
}

