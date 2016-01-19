#<> openssh: disallow root login
default['openssh']['server']['permit_root_login'] = 'no'
#<> openssh: disallow password authentication
default['openssh']['server']['password_authentication'] = 'no'
#<> openssh: use only SSHv2
default['openssh']['server']['protocol'] = '2'
#<> openssh: set accepted_env to 'LANG LC_*'
default['openssh']['server']['accept_env'] = 'LANG LC_*'
#<> openssh: define sftp subsystem
default['openssh']['server']['subsystem'] = 'sftp /usr/lib/openssh/sftp-server'
