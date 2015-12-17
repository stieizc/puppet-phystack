# Openstack repo setup
class openstack::repo {
  require ::epel
  $repo_package = hiera('openstack::repo::package')
  if $::osfamily == 'RedHat' {
    package { $repo_package:
      ensure => latest,
    }
    ~>
    exec { 'yum makecache':
      user        => root,
      path        => '/usr/bin',
      refreshonly => true,
    }
  }
}
