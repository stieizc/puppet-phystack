# Profile for controller setup
class profile::openstack::controller {
  include profile::ntp::client
  include openstack::base
}
