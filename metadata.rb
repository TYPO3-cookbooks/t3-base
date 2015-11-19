name             "t3-base"
maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Installs and updates basic software packages deployed to every node."

version          "0.2.2"

# TYPO3 cookbooks (pin to minor version: "~> a.b.0")
depends "hwraid",     "~> 1.1.0"
depends "locales",    "~> 1.1.0"
depends "etckeeper",  "~> 1.0.0"
depends "t3-zabbix",  "~> 0.2.0"
depends "ohmyzsh",    "~> 1.0.0"
depends "t3-openvz",  "~> 1.1.0"
depends "t3-kvm",     "~> 1.1.0"

# Upstream cookbooks (pin to patch-level version: "= a.b.c")
depends "chef_handler", "= 1.0.6"
depends "git",          "= 4.2.4"
depends "openssh",      "= 1.3.4"
depends "rsync",        "= 0.7.0"
depends "screen",       "= 0.7.0"
depends "postfix",      "= 3.7.0"
