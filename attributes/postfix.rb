# wWe do not want <localuser>@srvXXX.typo3.org as sender, as this domain does not exist (and mail server would reject mails)
# Instead, we send mails from <localuser>@typo3.org by specifying the masquerade_domain
default['postfix']['main']['masquerade_domains'] = (node['domain'] || node['hostname']).to_s.chomp('.')

default['postfix']['aliases']['root'] = "admin@typo3.org"