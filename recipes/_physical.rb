Chef::Log.info "Executing #{cookbook_name}::#{recipe_name}"

include_recipe "hwraid::default"
include_recipe "ntp::default"
include_recipe "lvm::default"
