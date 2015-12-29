# Openstack Glance database

class openstack::glance::db
inherits openstack::glance::params {
  class { '::glance::db::mysql':
    user     => $openstack::glance::params::db_user,
    password => $openstack::glance::params::db_password,
    dbname   => $openstack::glance::params::db_name,
    host     => 'localhost',
  }

  exec { 'glance-manage db_sync':
    command     => 'glance-manage db_sync',
    path        => '/usr/bin',
    user        => 'glance',
    refreshonly => true,
    require     => User['glance'],
    subscribe   => [
        Class[Openstack::Glance::Install],
        Class[Openstack::Glance::Config],
        Class[::Glance::Db::Mysql],
    ],
  }
}

