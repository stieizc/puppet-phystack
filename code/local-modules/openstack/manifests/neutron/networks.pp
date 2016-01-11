# Neutron add networks
class openstack::neutron::networks {
  hiera('neutron::public_nets').each | Hash $net | {
    create_resources(neutron_network, {
      $net['name'] => $net['detail'],
      }, {
      ensure                => present,
      tenant_name           => 'admin',
      shared                => true,
      provider_network_type => 'flat',
      }
    )

    create_resources(neutron_subnet, $net['subnets'], {
      ensure       => present,
      tenant_name  => 'admin',
      network_name => $net['name'],
      })
  }

  hiera('neutron::private_nets').each | Hash $net | {
    create_resources(neutron_network, {
      $net['name'] => $net['detail'],
      }, {
      ensure                => present,
      tenant_name           => 'demo',
      shared                => false,
      provider_network_type => 'vxlan',
      }
    )

    create_resources(neutron_subnet, $net['subnets'], {
      ensure       => present,
      tenant_name  => 'demo',
      network_name => $net['name'],
      })
  }

  hiera('neutron::routers').each | Hash $router | {
    create_resources(neutron_router, {
      $router['name'] => $router['detail'],
      }, {
      ensure      => present,
      tenant_name => 'admin',
      })

      $router['interfaces'].each | String $interface | {
        create_resources(neutron_router_interface, {
          "${router['name']}:${interface}" => {
            ensure => present,
          }
          })
      }
  }
}
