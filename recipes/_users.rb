include_recipe "sudo"

# check if the "users" data bag exists. if not, just skip the
# remainder of this recipe.
begin
  data_bag(:users)
rescue Net::HTTPServerException
  Chef::Log.warn("Data bag \"users\" doesn't exist")
  return
end

##############
# sysadmins
##############

# automatically add all users in the sysadmin group
include_recipe "users::sysadmins"


##############
# users defined for this node
##############

node_attribute = "fqdn"
log "Searching for users associated with node #{node[node_attribute]}"
begin
  users = search(:users, "nodes:#{node[node_attribute]}")
rescue Net::HTTPServerException
  Chef::Log.warn "Searching for users in the 'users' databag failed, search for users associated with node '#{node[node_attribute]}'"
  users = {}
end

users.each do |u|
  node_options = u['nodes'][node[node_attribute]]
  Chef::Log.info "Got node options: #{node_options}"
  if u['action'] == "remove" || node_options['action'] == "remove"
    user u['username'] ||= u['id'] do
      action :remove
    end
  else
    security_group = []
    u['username'] ||= u['id']
    security_group << u['username']

    home_dir = "/home/#{u['username']}"

    # The user block will fail if the group does not yet exist.
    # See the -g option limitations in man 8 useradd for an explanation.
    # This should correct that without breaking functionality.
    group u['username'] do
      gid u['gid']
      only_if { u['gid'] && u['gid'].is_a?(Numeric) }
    end

    # Create user object.
    user u['username'] do
      uid u['uid']
      gid u['gid'] if u['gid']
      shell u['shell']
      comment u['comment']
      password u['password'] if u['password']
      supports manage_home: true
      home home_dir
      action u['action'] if u['action']
    end

    # ssh key management
    directory "#{home_dir}/.ssh" do
      owner u['uid']
      group u['gid'] if u['gid']
      mode '0700'
    end

    file "#{home_dir}/.ssh/authorized_keys" do
      content Array(u['ssh_keys']).join("\n")
      owner u['uid']
      group u['gid'] if u['gid']
      mode '0600'
      only_if { u['ssh_keys'] }
    end

    # sudo management
    if node_options['sudo'] == "true"
      sudo u['username'] do
        nopasswd true
        user u['username']
      end
    else
      sudo u['username'] do
        action :remove
      end
    end
  end
end