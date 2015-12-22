# Openstack Neutron configuration

class openstack::neutron::config
inherits openstack::neutron::params {
  include openstack::neutron::params
  group { 'neutron':
    ensure => present,
    system => true,
  }

  user { 'neutron':
    ensure => 'present',
    gid    => 'neutron',
    system => true,
  }

  file { [
    '/etc/neutron', '/etc/neutron/plugins',
    '/etc/neutron/plugins/ml2',
    '/var/log/neutron', '/var/lib/neutron']:
    ensure  => directory,
    mode    => '0750',
    owner   => 'neutron',
    group   => 'neutron',
    require => [Group['neutron'], User['neutron']],
  }

  [
    'neutron.conf', 'plugins/ml2/ml2_conf.ini',
    'plugins/ml2/linuxbridge_agent.ini', 'l3_agent.ini', 'dhcp_agent.ini',
    'metadata_agent.ini'
  ].each |String $config| {
    file { "/etc/neutron/$config":
      ensure  => file,
      content => epp("openstack/neutron/${config}.epp"),
      mode    => '0600',
      owner   => 'neutron',
      group   => 'neutron',
      require => [Group['neutron'], User['neutron']],
      backup  => '.puppet-bak',
    }
  }

  file { '/etc/neutron/dnsmasq-neutron.conf':
      ensure  => file,
      source  => "puppet:///modules/openstack/neutron/dnsmasq-neutron.conf",
      mode    => '0600',
      owner   => 'neutron',
      group   => 'neutron',
      require => [Group['neutron'], User['neutron']],
      backup  => '.puppet-bak',
  }

  file { '/etc/neutron/plugin.ini':
    ensure => link,
    target => '/etc/neutron/plugins/ml2/ml2_conf.ini',
    require => [File['/etc/neutron/plugins/ml2/ml2_conf.ini']],
  }
}

