Datacenter  / Production Configuration
======================================

The `t3-base::_datacenter` recipe detects, if we are running in a production data center. It therefore searches the `datacenters`
data bag for entries including the (physical) server that we are running on.

If it is detected that we are running in the data center, the `t3-base::_production` recipe is automatically included.
This applies production-only configuration (chef-client config, backup, monitoring). **Make sure that the things
added here have no impact on other configuration!**

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