# NTP params
class profile::ntp::params {
  $upstream_servers = [
    'ntp.sjtu.edu.cn',
    's1a.time.edu.cn',
    's1b.time.edu.cn',
    's1c.time.edu.cn',
    's1d.time.edu.cn',
    's1e.time.edu.cn',
  ]
}
