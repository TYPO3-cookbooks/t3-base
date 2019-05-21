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

# apt-key needs dirmngr which is no longer installed by default on Debian Stretch
package "dirmngr" do
  action :upgrade
  only_if { node[:platform] == "debian" and node[:platform_version].to_i >= 9 }
end
