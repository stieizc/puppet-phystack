# Openstack repo setup
class openstack::repo {
  require ::epel
  $repo = hiera('openstack::repo')
  if $::osfamily == 'RedHat' {
    package { $repo:
      ensure => latest,
    }
  }
}
