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
  tcpdump
  telnet
  tig
  traceroute
  wget
  whois
}

packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end