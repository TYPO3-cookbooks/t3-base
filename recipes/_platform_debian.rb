# Cookbook Name:: t3-base
# Recipe:: squeeze-lts
# Author:: Michael Stucki <michael.stucki@typo3.org>
#
# Copyright 2014, Michael Stucki
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Add the squeeze-lts repository

if node[:platform] == "debian" and node[:platform_version].to_i < 7
  log "Executing Debian Squeeze specific resources"

  apt_repository "squeeze-lts" do
    uri "http://archive.debian.org/debian/"
    distribution "squeeze-lts"
    components ['main', 'contrib', 'non-free']
    action :add
  end

  # As of February 2016 the certificate for *.typo3.org is signed by a root CA
  # that is not trusted by Debian Squeeze. Therefore, add this certificate to
  # the trust store.
  # Original file:
  # https://www.geotrust.com/resources/root_certificates/certificates/Geotrust_PCA_G3_Root.pem
  cookbook_file "/usr/local/share/ca-certificates/Geotrust_PCA_G3_Root.crt" do
    source "Geotrust_PCA_G3_Root.pem"
    notifies :run, "execute[update-ca-certificates]"
    mode "0744"
  end
  execute "update-ca-certificates" do
    action :nothing
  end

end

package "lsb-release"