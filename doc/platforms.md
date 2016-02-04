Platform (OS) specific Recipes
==============================

To provide platform-specific configuration (e.g. for Debian 7 or all Ubuntu versions), the `default` recipe
automatically tries to include the following (eventually existing) recipes:

* `t3-base::_platform_family_#{node[:platform_family]}`
* `t3-base::_platform_#{node[:platform]}`

This results in the `_platform_familiy_debian` recipe being included for Debian and Ubuntu systems, while
`_platform_ubuntu` will be included for Ubuntu and `_platform_debian` for Debian systems.