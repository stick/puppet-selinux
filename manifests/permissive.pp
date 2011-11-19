#
# Class selinux::permissive
#
class selinux::permissive inherits selinux {
  exec { 'disable-selinux':
    command         => '/usr/sbin/setenforce permissive',
    onlyif          => '/usr/sbin/selinuxenabled',
    unless          => '/usr/sbin/sestatus |egrep -si "current mode: * permissive"',
  }

  file { '/etc/selinux/config':
    source => 'puppet:///selinux/permissive',
    mode   => 0644,
  }
}
