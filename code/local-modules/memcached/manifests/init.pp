# Memcached Setup

class memcached {
  package { 'memcached': }
  ->
  service { 'memcached':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
