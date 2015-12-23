# Openstack Horizon Setup
class openstack::horizon
inherits openstack::horizon::params {
  class { '::horizon':
    cache_backend         =>
    'django.core.cache.backends.memcached.MemcachedCache',
    cache_server_ip       => 'localhost',
    allowed_hosts         => '*',
    secret_key            => $openstack::horizon::params::secret,
    keystone_default_role => 'user',
    configure_apache      => false,
  }
  ->
  file_line { 'horizon time zone':
    ensure => present,
    path   => '/etc/openstack-dashboard/local_settings',
    line   => 'TIME_ZONE = "Asia/Shanghai"',
    match  => 'TIME_ZONE = .*',
  }
  class { '::horizon::wsgi::apache':
    priority => '10',
  }
}
