# We do not want <localuser>@srvXXX.typo3.org as sender, as this domain does not exist (and mail server would reject mails)
# Instead, we send mails from <localuser>@typo3.org by specifying the masquerade_domain
default['postfix']['main']['masquerade_domains'] = (node['domain'] || node['hostname']).to_s.chomp('.')

default['postfix']['aliases']['root'] = "admin@typo3.org"

#<> Some applications try to send mails from root@localhost, which are not accepted by the mail server. Rewrite those to root@typo3.org
default['postfix']['smtp_generic_map_entries'] = { "@localhost" => "@typo3.org" }

#<> Relay outgoing mail via mailrelay.typo3.org (which then use mail.typo3.org)
default['postfix']['main']['relayhost'] = 'mailrelay.typo3.org'
