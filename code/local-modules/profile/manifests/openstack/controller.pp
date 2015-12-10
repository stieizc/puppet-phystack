# Profile for controller setup
class profile::openstack::controller {
  include openstack::base
  include profile::ntp::client
  include profile::database
  include profile::mq
  include openstack::keystone
  Class['Profile::Ntp::Client'] -> Class['Profile::Mq']
  [
    Class['Openstack::Base'], Class['Profile::Mq'], Class['Profile::Database']
  ] -> Class['Openstack::Keystone']

  include openstack::glance
  Class['Openstack::Keystone'] -> Class['Openstack::Glance']

  include openstack::nova
  Class['Openstack::Keystone'] -> Class['Openstack::Nova']

  include openstack::neutron
  Class['Openstack::Nova'] -> Class['Openstack::Neutron']

  include openstack::horizon
  [Class['Openstack::Nova'], Class['Openstack::neutron']] -> Class['Openstack::Horizon']
}
