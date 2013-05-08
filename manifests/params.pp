
class ntp::params inherits ntp::default {

  $base_name = 'ntp'

  #---

  $build_package_names  = module_array('build_package_names')
  $common_package_names = module_array('common_package_names')
  $extra_package_names  = module_array('extra_package_names')
  $package_ensure       = module_param('package_ensure', 'present')

  #---

  $config_file     = module_param('config_file')
  $config_template = module_param('config_template', 'NTPConf')
  $config          = module_hash('config')

  #---

  $service_name    = module_param('service_name')
  $service_ensure  = module_param('service_ensure', 'running')
}
