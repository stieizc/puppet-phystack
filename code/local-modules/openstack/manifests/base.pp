# Puppet for openstack base setup
class openstack::base {
  require openstack::repo

  package { ['openstack-selinux']:
    ensure => latest
  }
  ->
  class { '::selinux':
    mode => 'permissive',
  }
}
