# Openstack Database setup
class profile::database
inherits profile::database::params {
  $root_password = hiera('database::accounts')['root']['password']
  class { '::mysql::server':
    root_password           => $root_password,
    remove_default_accounts => true,
    override_options        => $profile::database::params::override_options,
  }
  ->
  class { '::mysql::bindings':
    python_enable       => true,
    python_package_name => 'python2-PyMySQL',
  }
}
