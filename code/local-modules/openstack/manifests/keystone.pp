# Openstack Keystone setup

class openstack::keystone
inherits openstack::keystone::params {
  require '::memcached'

  include '::keystone::client'

  package { $openstack::keystone::params::packages:
    ensure => latest,
  }

  file { '/etc/keystone/keystone.conf':
    ensure  => file,
    content => epp('openstack/keystone/keystone.conf.epp'),
    backup  => '.puppet-bak',
    notify  => Service['httpd'],
  }

  class { '::keystone::db::mysql':
    user     => $openstack::keystone::params::db_user,
    password => $openstack::keystone::params::db_password,
    dbname   => $openstack::keystone::params::db_name,
  }

  include '::keystone::db::sync'

  class { '::keystone::wsgi::apache':
    ssl => false,
  }

  include 'openstack::keystone::credentials'
}
