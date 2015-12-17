# NTP params
class profile::ntp::params {
  $upstream_servers = [
    'ntp.sjtu.edu.cn iburst',
    's1a.time.edu.cn iburst',
    's1b.time.edu.cn iburst',
    's1c.time.edu.cn iburst',
    's1d.time.edu.cn iburst',
    's1e.time.edu.cn iburst',
  ]
}
