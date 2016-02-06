#<> Rotate logs on a daily basis
default['logrotate']['global']['daily'] = true
#<> Keep 7 days of logs
default['logrotate']['global']['rotate'] = "7"
#<> Only rotate log, if it has content
default['logrotate']['global']['notifempty'] = true
#<> Compress logs
default['logrotate']['global']['compress'] = true
#<> Do not number rotated logs, use date in filename (better for backup)
default['logrotate']['global']['dateext'] = true
