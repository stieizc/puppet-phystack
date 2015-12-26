# Openstack Nova config
class openstack::nova::config
inherits openstack::nova::params {
  include openstack::neutron::params
  group { 'nova':
    ensure => present,
    system => true,
  }

  user { 'nova':
    ensure => 'present',
    gid    => 'nova',
    system => true,
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

  $qemu_conf = '/etc/libvirt/qemu.conf'
  file_line { "${qemu_conf} user":
    ensure  => present,
    line    => 'user = "nova"',
    path    => $qemu_conf,
    after   => /^\s*#\s*user\s*=/,
    match   => /^\s*user\s*=/,
    require => [Group['nova'], User['nova']],
  }
  file_line { "${qemu_conf} group":
    ensure  => present,
    line    => 'group = "nova"',
    path    => $qemu_conf,
    after   => /^\s*#\s*group\s*=/,
    match   => /^\s*group\s*=/,
    require => [Group['nova'], User['nova']],
  }
}
