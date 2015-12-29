# Profile for message queue
class profile::mq {
  $user_data = hiera('mq::accounts')['common']
  $user = $user_data['name']
  $vhost = hiera('mq::vhost')
  package { 'rabbitmq-server':
    ensure => latest,
  }
  ->
  rabbitmq_user { 'guest':
    ensure => absent,
  }
  ->
  rabbitmq_user { $user:
    password => $user_data['password'],
  }
  ->
  rabbitmq_user_permissions { "${user}@${vhost}":
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }
}
