# Openstack Nova Database
class openstack::nova::db
inherits openstack::nova::params {
  class { '::nova::db::mysql':
    user     => $openstack::nova::params::db_user,
    password => $openstack::nova::params::db_password,
    dbname   => $openstack::nova::params::db_name,
    host     => 'localhost',
  }

  exec { 'nova-manage db sync':
    command     => 'nova-manage db sync',
    path        => '/usr/bin',
    user        => 'nova',
    refreshonly => true,
    require     => User['nova'],
    subscribe   => [
      Class[Openstack::Nova::Install],
      Class[Openstack::Nova::Config],
      Class[::Nova::Db::Mysql],
    ],
  }
}
