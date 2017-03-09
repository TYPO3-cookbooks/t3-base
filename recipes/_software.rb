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
