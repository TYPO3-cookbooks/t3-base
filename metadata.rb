name             "base"
maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Installs and updates basic software packages deployed to every node."
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))

version          "0.0.8"

depends "chef_handler", "= 1.0.6"
depends "etckeeper", "= 1.0.0"
depends "locales", "= 1.1.1"
depends "git", "= 0.9.0"
depends "ohmyzsh", "= 1.0.6"
depends "openssh", "= 0.8.3"
depends "rsync", "= 0.7.0"
depends "screen", "= 0.7.0"
depends "t3-zabbix", "= 0.1.11"
