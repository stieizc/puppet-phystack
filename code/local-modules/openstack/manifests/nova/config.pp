# Openstack Nova config
class openstack::nova::config
inherits openstack::nova::params {
  group { 'nova':
    ensure  => present,
    system  => true,
  }

  user { 'nova':
    ensure  => 'present',
    gid     => 'nova',
    system  => true,
  }

  file { ['/etc/nova', '/var/log/nova', '/var/lib/nova']:
    ensure  => directory,
    mode    => '0750',
    owner   => 'nova',
    group   => 'nova',
    require => [Group['nova'], User['nova']],
  }

  file { $openstack::nova::params::config:
    ensure  => file,
    content => epp('openstack/nova/nova.conf.epp'),
    mode    => '0600',
    owner   => 'nova',
    group   => 'nova',
    require => [Group['nova'], User['nova']],
    backup  => '.puppet-bak',
  }
}
