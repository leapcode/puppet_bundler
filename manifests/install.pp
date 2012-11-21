# Class bundler::install
#
# Installs bundler Ruby gem manager
#
# == Parameters
#
#   [*use_rvm*]
#     Sets whether rvm is used. Defaults to true.
#   [*ruby_version*]
#     Ruby version that bundler will use.
#
# == Examples
#
#
# == Requires:
#
#   If use_rvm = 'true':
#   include rvm
#
class bundler::install (
  $ruby_version    = undef,
  $ensure          = 'present',
  $install_method  = 'rvm',
  ) inherits bundler::params {

  if $install_method == undef {
    $provider_method = undef
  }
  else {
    $provider_method = $bundler::params::install_method
  }

  if $provider_method == 'rvm' {
    if $ruby_version == undef {
      fail('When using rvm, you must pass a ruby_version')
    }
    else {
      #Install bundler with correct RVM
      rvm_gem { 'bundler':
        ensure       => $ensure,
        ruby_version => $ruby_version,
      }
    }
  }
  else {
    package { 'bundler':
      ensure   => $ensure,
      provider => $provider_method,
    }
  }

}
