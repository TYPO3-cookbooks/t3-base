# recipes that should be included, if we are in production
include_recipe "t3-zabbix::agent"
include_recipe "backuppc"

##############
# chef-client
##############

# If we would include t3-chef-client in test-kitchen, this would result in a
# 401 Unauthorized
# error when searching the sysadmin data bag in the users_manage("sysadmin") resource.
# Therefore, exclude t3-chef-client, if we have this magic attribute set
unless node['t3-base'] && node['t3-base']['prevent-t3-chef-client-inclusion-for-testing']
  include_recipe 't3-chef-client'
  include_recipe 't3-chef-client::knife-lastrun'
end


##############
# etckeeper
##############
include_recipe "etckeeper::commit"

# We add the Etckeeper::StartHandler (installed by etckeeper::commit) as start handler to chef
template "#{node['chef_client']['conf_dir']}/client.d/etckeeper_handler.rb" do
  source "etckeeper_handler.rb.erb"
  # this does not work in test-kitchen, as we don't have the client.d/ directory -> ignore failure
  ignore_failure true
end


#################
# postfix aliases
#################

if Chef::DataBag.list.key?('users')
  sysadmins = search("users", "groups:sysadmin AND NOT action:remove")

  aliases_root = []
  sysadmins.each do |user|
    aliases_root << user['email']
    Chef::Log.info "Set up alias for user #{user['id']}"
    node.set['postfix']['aliases'][user['id']] = user['email']
  end
  node.set['postfix']['aliases']['root'] = aliases_root.sort
else
  Chef::Log.warn("Data bag \"users\" doesn't exist")
end
