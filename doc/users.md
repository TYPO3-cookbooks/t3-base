Users
=====

This recipe manages users based on the `users` data bag.

* All users with `group: sysadmin` are automatically assigned to all nodes with _sudo_ privileges.
* All other users are added based on their assignment to particular hosts. The `users` data bag is
searched for items that contain an entry for `node['fqdn']` in the `"nodes"` key of the data bag:

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