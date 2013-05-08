
class ntp::default {

  case $::operatingsystem {
    debian, ubuntu: {
      $common_package_names = ['ntp']
      $service_name         = 'ntp'

      $config_file = '/etc/ntp.conf'

      # For configuration information, see http://support.ntp.org/bin/view/Support/ConfiguringNTP
      $config = {
        'driftfile'  => '/var/lib/ntp/ntp.drift',
        'statistics' => 'loopstats peerstats clockstats',
        'filegen'    => [
          'loopstats file loopstats type day enable',
          'peerstats file peerstats type day enable',
          'clockstats file clockstats type day enable'
        ],
        'server'     => [
          '0.debian.pool.ntp.org iburst',
          '1.debian.pool.ntp.org iburst',
          '2.debian.pool.ntp.org iburst',
          '3.debian.pool.ntp.org iburst'
        ],
        'restrict' => [
          '-4 default kod notrap nomodify nopeer noquery',
          '-6 default kod notrap nomodify nopeer noquery',
          '127.0.0.1',
          '::1'
        ]
      }
    }
  }
}
