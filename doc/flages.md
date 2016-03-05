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