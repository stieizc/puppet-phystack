# Profile for controller setup
class profile::openstack::controller {
  include openstack::base
  include profile::ntp::client
  include profile::database
  include profile::mq
  include openstack::keystone
  Class['profile::ntp::client'] -> Class['profile::mq']
  [
    Class['openstack::base'], Class['profile::mq'], Class['profile::database']
  ] -> Class['openstack::keystone']
}
