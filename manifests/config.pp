# Define bundler::config
# 
# All config settings for candiapp class
#
# == Parameters
#
#   [*user*]
#     App directory owner
#   [*config_flag*]
#     config flag for specific gem compile settings
#   [*app_dir*]
#     App directory where Gemfile is located
#   [*home_dir_base_path*]
#     Home directory of the specified user 
#   [*use_rvm*]
#      Sets whether rvm is used. Defaults to true
#   [*rvm_bin*]
#     RVM install location. Defaults to /usr/local/rvm/bin/rvm
#   [*rvm_gem_path*]
#     RVM gem directory. Defaults to /usr/local/rvm/gems
#   [*rvm_gemset*]
#     RVM gemset to use. Defaults to global.
#   [*ruby_version*]
#     Ruby version for RVM purposes. Defaults to ruby-1.9.2-p290
#   [*bundler_path*]
#     Bundler install directory
#
# == Examples
#
#
# == Requires:
#
#   class { bundler::install: }
#
define bundler::config (
  $user,
  $config_flag,
  $app_dir,
  $home_dir_base_path = $bundler::params::home_dir_base_path,
  $use_rvm            = $bundler::params::use_rvm,
  $rvm_bin            = $bundler::params::rvm_bin,
  $rvm_gem_path       = $bundler::params::rvm_gem_path,
  $rvm_gemset         = $bundler::params::rvm_gemset,
  $ruby_version       = $bundler::params::ruby_version,
  $bundler_path       = $bundler::params::bundler_path
) {

  Class['bundler::install'] -> Bundler::Config["${name}"]

  if $user == 'root' {
    $home_dir = '/root'
  }
  else {
    $home_dir = "${home_dir_base_path}/$user"
  }

  # Must use $bundler_path_real, otherwise cannot reassign variable error is thrown
  if $use_rvm == 'true' {
    $bundler_path_rvm = "${rvm_gem_path}/${ruby_version}@${rvm_gemset}/bin"
    $bundler_config_command = "${rvm_bin} ${ruby_version} exec ${bundler_path_rvm}/bundle config build.${name} ${config_flag}"
  }
  else {
    $bundler_config_command = "${bundler_path}/bundle config build.${name} ${config_flag}"
  }

  exec { "bundler_config_${name}":
    cwd     => $app_dir,
    command => $bundler_config_command,
    unless  => "/bin/grep -i \"BUNDLE_BUILD__${name}: ${config_flag}\" ${home_dir}/.bundle/config",
    user    => $user,
  }

}
