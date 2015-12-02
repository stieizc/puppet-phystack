# Puppet for openstack base setup
class openstack::base {
  require openstack::repo
  ['python-openstackclient', 'openstack-selinux'].each |String $pkg| {
    package { $pkg:
      ensure => latest
    }
  }
}
