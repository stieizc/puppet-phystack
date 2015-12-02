# Profile for controller setup
class profile::openstack::controller {
  include openstack::base
  include profile::ntp::client
  include profile::database
  include profile::mq
}
