# Profile for ntp client
class profile::ntp::client
inherits profile::ntp::params {
  class { '::chrony':
    servers => $profile::ntp::params::upstream_servers
  }
}
