#
# Class selinux::disabled
#
#   We don't actually allow disabling of selinux
#
class selinux::disabled inherits selinux {
  fail 'Disabling selinux is not a supported configuration, use ::permissive instead'
}
