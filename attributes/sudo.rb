#<> Include everything from /etc/sudoers.d/
default['authorization']['sudo']['include_sudoers_d'] = true
#<> Set up `secure_path`, otherwise $PATH will be very short after sudo'ing
default['authorization']['sudo']['sudoers_defaults'] = [
  'env_reset',
  'env_keep+="SSH_AUTH_SOCK DEBIAN_FRONTEND"',
  'secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"'
]