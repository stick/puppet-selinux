#
# Define: selinux::module
#
# Usage: selinux::module { 'modulename': }
#   default directory: /usr/share/selinux/packages
#
define selinux::module (
  $selinux_module_dir = '/usr/share/selinux/packages',
  $source
) {
  if $selinux and $selinux_enforced {
    file { "${selinux_module_dir}/${name}.pp":
      source  => $source,
    }

    selmodule { "${name}":
      ensure          => 'present',
      selmoduledir    => $selinux_module_dir,
    }
  }
}
