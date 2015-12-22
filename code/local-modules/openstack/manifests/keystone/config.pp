# Openstack Keystone configuration

class openstack::keystone::config
inherits openstack::keystone::params {
  group { 'keystone':
    ensure => present,
    system => true,
  }

  user { 'keystone':
    ensure => 'present',
    gid    => 'keystone',
    system => true,
  }

  file { ['/etc/keystone', '/var/log/keystone', '/var/lib/keystone']:
    ensure  => directory,
    mode    => '0750',
    owner   => 'keystone',
    group   => 'keystone',
    require => [Group['keystone'], User['keystone']],
  }

  file { $openstack::keystone::params::config:
    ensure  => file,
    content => epp('openstack/keystone/keystone.conf.epp'),
    mode    => '0600',
    owner   => 'keystone',
    group   => 'keystone',
    require => [Group['keystone'], User['keystone']],
    backup  => '.puppet-bak',
  }
}

