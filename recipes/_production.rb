# recipes that should be included, if we are in production
production_recipes = %w(
etckeeper::commit
t3-zabbix::agent
backuppc
)

# We add the Etckeeper::StartHandler (installed by etckeeper::commit) as start handler to chef
node.set['chef_client']['start_handlers'] = [
  {
    :class => 'Etckeeeper::StartHandler',
    :arguments => []
  }
]

# If we would include t3-chef-client in test-kitchen, this would result in a
# 401 Unauthorized
# error when searching the sysadmin data bag in the users_manage("sysadmin") resource.
# Therefore, exclude t3-chef-client, if we have this magic attribute set
unless node['t3-base'] && node['t3-base']['prevent-t3-chef-client-inclusion-for-testing']
  production_recipes << 't3-chef-client'
  production_recipes << 't3-chef-client::knife-lastrun'
end

production_recipes.each do |recipe|
  include_recipe recipe
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
  node.set['postfix']['aliases']['root'] = aliases_root
else
  Chef::Log.warn("Data bag \"users\" doesn't exist")
end
