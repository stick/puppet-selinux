#
# Class: selinux
#   default action is enforcing
#
class selinux {
  case $operatingsystem {
    'redhat': {
      $package_list = [
        'policycoreutils',
        'setroubleshoot-server'
      ]
    }
  }

  service { 'restorecond':
    ensure => running,
    require => Package['policycoreutils'],
  }

  if ($operatingsystemrelease == '6') {
    package { 'libselinux-ruby':
      ensure  => installed,
    }
  } else {
    service { 'setroubleshoot': 
      ensure          => running,
      enable          => true,
      require         => Package['setroubleshoot-server'],
    }
  }

  if !defined(Class['selinux::permissive']) {
    # nothing happens here
    $trash = 'nothing'
  } else {
    exec { 'enable-selinux':
      command         => '/usr/sbin/setenforce enforcing',
      onlyif          => '/usr/sbin/selinuxenabled',
      unless          => '/usr/sbin/sestatus | egrep -si "current mode: * enforcing"',
    }
  }
}

