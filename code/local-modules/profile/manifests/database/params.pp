# Openstack Database parameters
class profile::database::params {
  $override_options = {
    'mysqld' => {
      'default-storage-engine' => 'innodb',
      'innodb_file_per_table'  => true,
      'character-set-server'   => 'utf8',
      'collation-server'       => 'utf8_general_ci',
      'init-connect'           => '\'SET NAMES utf8\'',
      'tmpdir'                 => undef,
    }
  }
}
