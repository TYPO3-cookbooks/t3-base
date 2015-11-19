# Description

Installs and updates basic software packages deployed to every node.

# Requirements

## Platform:

* Debian
* Ubuntu

## Cookbooks:

* t3-zabbix

# Attributes

*No attributes defined*

# Recipes

* t3-base::default
* t3-base::production

# Libraries

* `include_if_available(recipe)` includes a recipe, if it exists.

# License and Maintainer

Maintainer:: TYPO3 Association (<steffen.gebert@typo3.org>)

License:: Apache 2.0
