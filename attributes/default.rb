# chef_handler
default[:chef_handler][:handler_path] = "/var/chef/handlers"

# etckeeper
default[:etckeeper][:git_remote_enabled] = false

# monit
default[:monit][:notify_email] = "typo3-team-server@lists.typo3.org"
default[:monit][:mail_format][:message] = <<-EOS
$EVENT Service $SERVICE
    Date:        $DATE
    Action:      $ACTION
    Host:        $HOST
    Description: $DESCRIPTION

Your faithful employee,
Monit
EOS
