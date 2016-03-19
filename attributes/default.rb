#<> chef_handler: the place where we store our chef handler
default[:chef_handler][:handler_path] = "/var/chef/handlers"

#<> etckeeper: disable remotes in etckeeper
default[:etckeeper][:git_remote_enabled] = false

#<> etckeeper: disable daily autocommit (AVOID_DAILY_AUTOCOMMIT)
default['etckeeper']['daily_auto_commits'] = true

#<> Do not install recommends packages
default['apt']['confd']['install_recommends'] = false
