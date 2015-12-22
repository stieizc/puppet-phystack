# Openstack Horizon configuration

class openstack::horizon::config
inherits openstack::horizon::params {
  file { '/etc/openstack-dashboard/':
    ensure => directory,
    mode   => '0750',
    owner  => 'root',
    group  => 'apache',
  }

  file { '/etc/openstack-dashboard/local_settings':
    ensure  => file,
    content => epp('openstack/openstack-dashboard/local_settings.epp'),
    backup  => '.puppet-bak',
  }
}

