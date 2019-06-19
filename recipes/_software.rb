packages = %w{
  bc
  curl
  htop
  iftop
  iotop
  lsb-release
  lynx
  mc
  nano
  parted
  rsync
  screen
  tcpdump
  telnet
  tig
  traceroute
  vim
  wget
  whois
}

package packages do
  action :upgrade
end


# Debian Stretch needs some packages which are no longer installed by default
stretch_packages = %w{
  gnupg
}

package stretch_packages do
  action :upgrade
  only_if { node[:platform] == "debian" and node[:platform_version].to_i >= 9 }
end
