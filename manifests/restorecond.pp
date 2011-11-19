#
# Define: selinux::restoreconf
#
#   Add path to restorecond.conf
#
#   requires:
#     - selinux
#
define selinux::restorecond ( ) {

  exec{ "echo '${name}' >> /etc/selinux/restorecond.conf":
    unless => "grep -qFx '${name}' /etc/selinux/restorecond.conf",
    path => "/bin:/sbin:/usr/bin:/usr/sbin",
    require => Package["policycoreutils"],
    notify => Service["restorecond"],
  }
}
