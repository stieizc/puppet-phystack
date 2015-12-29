# Openstack Neutron database

class openstack::neutron::db
inherits openstack::neutron::params {
  class { '::neutron::db::mysql':
    user     => $openstack::neutron::params::db_user,
    password => $openstack::neutron::params::db_password,
    dbname   => $openstack::neutron::params::db_name,
    host     => 'localhost',
  }

  $extra_params = '--config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugin.ini'

  exec { 'neutron-manage db_sync':
    command     => "neutron-db-manage ${extra_params} upgrade head",
    path        => '/usr/bin',
    user        => 'neutron',
    refreshonly => true,
    require     => User['neutron'],
    subscribe   => [
        Class[Openstack::Neutron::Install],
        Class[Openstack::Neutron::Config],
        Class[::Neutron::Db::Mysql],
    ],
  }
}

