# Horizon Parameters
class openstack::horizon::params {
  $secret = hiera('horizon::django_secret')
  $packages = [openstack-dashboard]
}
