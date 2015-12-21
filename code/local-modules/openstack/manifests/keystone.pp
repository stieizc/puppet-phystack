# Openstack Keystone setup

class openstack::keystone
inherits openstack::keystone::params {
  require '::memcached'

  include '::keystone::client'

  package { $openstack::keystone::params::packages:
    ensure => latest,
  }

  file { $openstack::keystone::params::config:
    ensure  => file,
    content => epp('openstack/keystone/keystone.conf.epp'),
    backup  => '.puppet-bak',
  }

  class { '::keystone::db::mysql':
    user     => $openstack::keystone::params::db_user,
    password => $openstack::keystone::params::db_password,
    dbname   => $openstack::keystone::params::db_name,
  }

  include '::keystone::db::sync'

  [
    File[$openstack::keystone::params::config],
    Class[Keystone::Db::Mysql],
    Class[Keystone::Db::Sync],
  ] ~> Service[Httpd]

  class { '::keystone::wsgi::apache':
    ssl => false,
  }

  include 'openstack::keystone::credentials'
}
