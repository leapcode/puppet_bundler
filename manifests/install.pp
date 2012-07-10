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
#   include rvm::system
#
class bundler::install (
  $use_rvm      = $bundler::params::use_rvm,
  $ruby_version = $bundler::params::ruby_version
) inherits bundler::params {

  if $use_rvm == 'true' {
    #Install bundler with correct RVM
    rvm_gem { 'bundler':
        ensure       => 'present',
        ruby_version => $ruby_version,
     }
  }
  else {
    package { 'bundler':
      ensure   => 'present',
      provider => 'gem',
    }
  }

}
