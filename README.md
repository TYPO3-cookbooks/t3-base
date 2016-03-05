# Description

Installs and updates basic software packages deployed to every node.

# Requirements

## Platform:

* debian

## Cookbooks:

* backuppc (~> 1.0.0)
* etckeeper (~> 1.0.0)
* hwraid (~> 1.1.0)
* locales (~> 1.1.0)
* ohmyzsh (~> 1.0.0)
* t3-chef-client (~> 0.4.0)
* t3-kvm (~> 0.1.0)
* t3-openvz (~> 1.1.0)
* t3-zabbix (~> 0.2.0)
* apt (= 2.9.2)
* chef_handler (= 1.0.6)
* git (= 4.2.4)
* logrotate (= 1.9.2)
* lvm (= 0.7.0)
* ntp (= 1.8.6)
* openssh (= 1.3.4)
* postfix (= 3.7.0)
* rsync (= 0.7.0)
* screen (= 0.7.0)
* sudo (= 2.6.0)
* users (= 2.0.3)

# Attributes

* `node['backuppc']['user']` - SSH user used for logins of the backup server. Defaults to `t3o-backup`.
* `node['backuppc']['user_ssh_pubkeys']` - SSH keys allowing the server to login. Defaults to `[ ... ]`.
* `node[:chef_handler][:handler_path]` - chef_handler: the place where we store our chef handler. Defaults to `/var/chef/handlers`.
* `node[:etckeeper][:git_remote_enabled]` - etckeeper: disable remotes in etckeeper. Defaults to `false`.
* `node['t3-base']['flags']['production']` - Defines, whether we are running in a production context, meaning that we want monitoring etc. This is enabled in the environment or alternatively for testing in .kitchen.yml. Defaults to `false`.
* `node['logrotate']['global']['daily']` - Rotate logs on a daily basis. Defaults to `true`.
* `node['logrotate']['global']['rotate']` - Keep 7 days of logs. Defaults to `7`.
* `node['logrotate']['global']['notifempty']` - Only rotate log, if it has content. Defaults to `true`.
* `node['logrotate']['global']['compress']` - Compress logs. Defaults to `true`.
* `node['logrotate']['global']['dateext']` - Do not number rotated logs, use date in filename (better for backup). Defaults to `true`.
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
* `node['authorization']['sudo']['sudoers_defaults']` - Set up `secure_path`, otherwise $PATH will be very short after sudo'ing. Defaults to `[ ... ]`.

# Recipes

* t3-base::default - Includes other recipes, some of them based on ohai detections
* t3-base::_physical - Recipes that we want on physical nodes
* t3-base::_users - Creates users based on the `users` data bag
* t3-base::_software - Different software that we want o nevery node
* t3-base::_platform_debian - Debian-specific configuration (e.g. LTS repos)
* t3-base::_platform_family_debian - Debian/Ubuntu-specific configuration (e.g. incude `apt`)
* t3-base::_datacenter - Detects, in which data center a node is and applies specific attributes based on the `datacenters` data bag
* t3-base::_production - Configuration that is only needed for production nodes (e.g. backup, monitoring, chef-client config)

Datacenter  / Production Configuration
======================================

The `t3-base::_datacenter` recipe detects, if we are running in a production data center. It therefore searches the `datacenters`
data bag for entries including the (physical) server that we are running on.

Such data bag entry can define data center specific **attributes** and **cookbooks** (for a server `test.vagrant` in
the `test` data center and its VMs):

```
{
  "name": "test",
  "servers": [
    "test.vagrant"
  ],
  "attributes": {
    "postfix": {
      "main": {
        "relayhost": "test.example.com"
      }
    }
  },
  "cookbooks": [
    "special-cookbook-for-dc-test"
  ]
}
```

The data center of a node is further saved in the `node[datacenter]` attribute.
To find out the datacenter, in which a node is running, use

```
$ knife node show whatever.typo3.org -a datacenter
whatever.typo3.org:
  datacenter: my_datacenter
```

Accordingly, you can use this attribute to search for all nodes in a datacenter:
```
$ knife search node "datacenter:my_datacenter"
```

Flags
=====

Some special use-cases and situations can be defined by setting flags below `node['t3-base']['flags']`.

Production Environment: `node['t3-base']['flags']['production']`
----------------------

The fact that we are running in production is triggered by `node['t3-base']['flags']['production'] = true`.
This results in an inclusion of the `t3-base::_production` recipe and applies production-only configuration
(chef-client config, backup, monitoring).
**Make sure that the things
added here have no impact on other configuration!**

Libraries
=========

* `include_if_available(recipe)` includes a recipe, if it exists.


Platform (OS) specific Recipes
==============================

To provide platform-specific configuration (e.g. for Debian 7 or all Ubuntu versions), the `default` recipe
automatically tries to include the following (eventually existing) recipes:

* `t3-base::_platform_family_#{node[:platform_family]}`
* `t3-base::_platform_#{node[:platform]}`

This results in the `_platform_familiy_debian` recipe being included for Debian and Ubuntu systems, while
`_platform_ubuntu` will be included for Ubuntu and `_platform_debian` for Debian systems.

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
