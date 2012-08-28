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
  $ensure       = 'present',
  $use_rvm      = $bundler::params::use_rvm,
  $ruby_version
) inherits bundler::params {

  if $use_rvm == 'true' {
    #Install bundler with correct RVM
    rvm_gem { 'bundler':
        ensure       => $ensure,
        ruby_version => $ruby_version,
     }
  }
  else {
    package { 'bundler':
      ensure   => $ensure,
      provider => 'gem',
    }
  }

}
