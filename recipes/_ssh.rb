#
# Cookbook Name:: t3-base
# Recipe:: _ssh
#
# Copyright 2016, TYPO3 Association
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

# this is esp. needed when running inside of docker
# https://github.com/chef-cookbooks/openssh/pull/92
directory "/var/run/sshd"

include_recipe "openssh"

# Chef 12.5.1 wrongly picked up upstart as provider for the service[ssh] resource
# when running in kitchen-docker on Debian 8.
# see https://github.com/TYPO3-cookbooks/t3-base/issues/1
# This might be also needed on newer Debian versions or might be fixed in newer
# versions of chef-client. It wasn't always reproducible, but occurred from time to time
# with error "No such file or directory - /sbin/status"
if in_docker? && node['platform'] == 'debian' && node['platform_version'].to_i == 8
  log 'patch-service-ssh-in-docker' do
    level :warn
    message 'Running inside docker, changing the provider for the service[ssh] resource to  Chef::Provider::Service::Init::Debian'
  end

  resources('service[ssh]').provider Chef::Provider::Service::Init::Debian
end
