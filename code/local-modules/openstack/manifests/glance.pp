# Openstack Glance Setup
class openstack::glance
inherits openstack::glance::params {
  include 'openstack::glance::credentials'

  package { $openstack::glance::params::packages:
    ensure => latest,
    tag    => ['glance-package'],
  }

  [api, registery].each |String $conf| {
    file { "/etc/glance/glance-${conf}.conf":
      ensure  => file,
      content => epp("openstack/glance/glance-${conf}.conf.epp"),
      backup  => '.puppet-bak',
      notice  => Class[Openstack::Glance],
      tag     => ['glance-config'],
    }
  }

  class { '::glance::db::mysql':
    user     => $openstack::glance::params::db_user,
    password => $openstack::glance::params::db_password,
    dbname   => $openstack::glance::params::db_name,
    host     => 'localhost',
  }

  service { [openstack-glance-api, openstack-glance-registry]:
    ensure => enabled,
    tag    => ['glance-service'],
  }

  include ::glance::db::sync
  File<| tag == 'glance-config' |> ~> Class[Glance::Db::Sync]
}
