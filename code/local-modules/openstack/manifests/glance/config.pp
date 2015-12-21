# Openstack Glance configuration

class openstack::glance::config
inherits openstack::glance::params {
  group { 'glance':
    ensure  => present,
    system  => true,
  }

  user { 'glance':
    ensure  => 'present',
    gid     => 'glance',
    system  => true,
  }

  file { ['/etc/glance', '/var/log/glance', '/var/lib/glance']:
    ensure  => directory,
    mode    => '0750',
    owner   => 'glance',
    group   => 'glance',
    require => [Group['glance'], User['glance']],
  }

  [api, registry].each |String $conf| {
    file { "/etc/glance/glance-${conf}.conf":
      ensure  => file,
      content => epp("openstack/glance/glance-${conf}.conf.epp"),
      backup  => '.puppet-bak',
    }
  }
}

