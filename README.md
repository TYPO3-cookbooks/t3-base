# Description

Installs and updates basic software packages deployed to every node.

# Requirements

## Platform:

* debian

## Cookbooks:

* hwraid (~> 1.1.0)
* locales (~> 1.1.0)
* etckeeper (~> 1.0.0)
* t3-zabbix (~> 0.2.0)
* ohmyzsh (~> 1.0.0)
* t3-openvz (~> 1.1.0)
* t3-kvm (~> 0.1.0)
* chef_handler (= 1.0.6)
* git (= 4.2.4)
* openssh (= 1.3.4)
* rsync (= 0.7.0)
* screen (= 0.7.0)
* postfix (= 3.7.0)
* ntp (= 1.8.6)
* lvm (= 0.7.0)
* users (= 2.0.1)

# Attributes

* `node[:chef_handler][:handler_path]` - chef_handler: the place where we store our chef handler. Defaults to `/var/chef/handlers`.
* `node[:etckeeper][:git_remote_enabled]` - etckeeper: disable remotes in etckeeper. Defaults to `false`.
* `node[:monit][:notify_email]` - monit: notification mail. Defaults to `typo3-team-server@lists.typo3.org`.
* `node[:monit][:mail_format][:message]` - monit: notification mail template. Defaults to `<<-EOS`.
* `node['ntp']['servers']` -  Defaults to `[ ... ]`.
* `node['openssh']['server']['permit_root_login']` - openssh: disallow root login. Defaults to `no`.
* `node['openssh']['server']['password_authentication']` - openssh: disallow password authentication. Defaults to `no`.
* `node['openssh']['server']['protocol']` - openssh: use only SSHv2. Defaults to `2`.
* `node['openssh']['server']['accept_env']` - openssh: set accepted_env to 'LANG LC_*'. Defaults to `LANG LC_*`.
* `node['openssh']['server']['subsystem']` - openssh: define sftp subsystem. Defaults to `sftp /usr/lib/openssh/sftp-server`.
* `node['postfix']['main']['masquerade_domains']` -  Defaults to `(node['domain'] || node['hostname']).to_s.chomp('.')`.
* `node['postfix']['aliases']['root']` -  Defaults to `admin@typo3.org`.
* `node['postfix']['smtp_generic_map_entries']` - Some applications try to send mails from root@localhost, which are not accepted by the mail server. Rewrite those to root@typo3.org. Defaults to `{ ... }`.
* `node['authorization']['sudo']['include_sudoers_d']` - Include everything from /etc/sudoers.d/. Defaults to `true`.

# Recipes

* t3-base::default - Includes other recipes, some of them based on ohai detections
* t3-base::_physical - Recipes that we want on physical nodes
* t3-base::_users - Creates users based on the `users` data bag
* t3-base::_software - Different software that we want o nevery node

Libraries
=========

* `include_if_available(recipe)` includes a recipe, if it exists.


Users
=====

This recipe manages users based on the `users` data bag.

* All users with `group: sysadmin` are automatically assigned to all nodes with _sudo_ privileges.
* All other users are added based on their assignment to particular hosts. The `users` data bag is
searched for items that contain an entry for `node['hostname']` in the `"nodes"` key of the data bag:

```
{
    "id": "a-srv123-admin",
    ...
    "nodes": {
            "srv123.typo3.org": {
                    "sudo": "true"
            }
    }
}
```

In order to remove a user from all nodes, `action: remove` can be set
on the highest level:

```
{
    "id": "a-user-to-remove",
    "action": "remove"
}
```

In order to remove a user from a certain node, `action: remove` can be set
on the node level:

```
{
    "id": "a-user-to-remove",
    ...
    "nodes": {
            "srv123.typo3.org": {
                    "action": "remove"
            }
    }
}
```

Keep in mind that deleting the data bag item or removing the entry in
`"nodes"` does not remove the user, of course.

# License and Maintainer

Maintainer:: TYPO3 Association (<steffen.gebert@typo3.org>)
Source:: https://github.com/typo3-cookbooks/t3-base

License:: Apache 2.0
