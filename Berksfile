source "https://supermarket.chef.io"

metadata

%w{
etckeeper
locales
ohmyzsh
openssh
t3-zabbix
zabbix
}.each do |cb|
  cookbook cb, github: "TYPO3-cookbooks/#{cb}"
end

# dependencies of t3-zabbix
cookbook "zabbix-custom-checks",     github: "TYPO3-cookbooks/zabbix-custom-checks"
