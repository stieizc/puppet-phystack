# Puppet for openstack base setup
class openstack::base {
  require openstack::repo
  ['openstack-selinux'].each |String $pkg| {
    package { $pkg:
      ensure => latest
    }
  }
}
