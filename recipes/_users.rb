# remove those two from roles/users_admin.rb
include_recipe "sudo"
include_recipe "users::sysadmins"