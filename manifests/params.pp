# Class bundler::params
#
# All config settings for candiapp class
#
# == Parameters
#
#
#
# == Examples
#
#
# == Requires:
#
class bundler::params {

  case $::operatingsystem {
    ubuntu, debian: {
      $user               = 'root'
      $home_dir_base_path = '/home'
      $use_rvm            = true
      $install_method     = gem
      $rvm_bin            = '/usr/local/rvm/bin/rvm'
      $rvm_gem_path       = '/usr/local/rvm/gems'
      $rvm_gemset         = 'global'
      $bundler_path       = '/usr/bin'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }

}
