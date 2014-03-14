# Class: ntp
#
#   This module manages NTP components.
#
#   Adrian Webb <adrian.webb@coralnexus.com>
#   2013-05-07
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters: (see <example/params.json> for Hiera configurations)
#
# Actions:
#
#  Installs, configures, and manages NTP components.
#
# Requires:
#
# Sample Usage:
#
#   include ntp
#
class ntp inherits ntp::params {

  $base_name = $ntp::params::base_name

  #-----------------------------------------------------------------------------
  # Installation

  corl::package { $base_name:
    resources => {
      build_packages  => {
        name => $ntp::params::build_package_names
      },
      common_packages => {
        name    => $ntp::params::common_package_names,
        require => 'build_packages'
      },
      extra_packages  => {
        name    => $ntp::params::extra_package_names,
        require => 'common_packages'
      }
    },
    defaults  => {
      ensure => $ntp::params::package_ensure
    }
  }

  #-----------------------------------------------------------------------------
  # Configuration

  corl::file { $base_name:
    resources => {
      config => {
        path    => $ntp::params::config_file,
        content => render($ntp::params::config_template, $ntp::params::config),
        notify  => Service["${base_name}_service"]
      }
    }
  }

  #-----------------------------------------------------------------------------
  # Actions

  corl::exec { $base_name: }

  #-----------------------------------------------------------------------------
  # Services

  corl::service { $base_name:
    resources => {
      service => {
        name       => $ntp::params::service_name,
        ensure     => $ntp::params::service_ensure,
        hasstatus  => true,
        hasrestart => true,
      }
    },
    require => [ Corl::Package[$base_name], Corl::File[$base_name] ]
  }

  #---

  corl::cron { $base_name:
    require => Corl::Service[$base_name]
  }
}
