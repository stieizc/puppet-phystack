# Profile for message queue
class profile::mq {
  $user_data = hiera('mq::accounts')['common']
  $user = $user_data['name']
  $vhost = hiera('mq::vhost')
  class { '::rabbitmq':
    delete_guest_user => true,
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
