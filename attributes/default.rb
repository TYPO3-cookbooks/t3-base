#<> chef_handler: the place where we store our chef handler
default[:chef_handler][:handler_path] = "/var/chef/handlers"

#<> etckeeper: disable remotes in etckeeper
default[:etckeeper][:git_remote_enabled] = false

#<> monit: notification mail
default[:monit][:notify_email] = "typo3-team-server@lists.typo3.org"
#<> monit: notification mail template
default[:monit][:mail_format][:message] = <<-EOS
$EVENT Service $SERVICE
    Date:        $DATE
    Action:      $ACTION
    Host:        $HOST
    Description: $DESCRIPTION

Your faithful employee,
Monit
EOS
