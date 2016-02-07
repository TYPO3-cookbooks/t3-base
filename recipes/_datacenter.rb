#
# Cookbook Name:: t3-base
# Recipe:: _datacenter
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

::Chef::Recipe.send(:include, Typo3::Base::Node)
::Chef::Recipe.send(:include, Typo3::Base::Recipe)

#############################
# who's my host?
#############################
if !node[:virtualization][:host].nil?
  physical_server = node[:virtualization][:host]
else
  physical_server = node[:fqdn]
end
Chef::Log.info "Physical server: #{physical_server}"

#############################
# search datacenters data bag
#############################

if Chef::DataBag.list.key?('datacenters')
  dc_data = search(:datacenters, "servers:#{physical_server}")
else
  Chef::Log.warn "No data bag 'datacenters' found. Hopefully we're in testing.."
  return
end

if dc_data.length == 0
  Chef::Log.warn "No data center found for physical server #{physical_server}"
  return
elsif dc_data.length > 1
  Chef::Application.fatal! "Server #{physical_server} is mentioned in more than one data center!"
else
  datacenter = dc_data.first
  Chef::Log.info "Found server #{physical_server} in data center #{datacenter[:id]}"
end

#################
# attributes
#################
unless datacenter[:attributes].nil? || datacenter[:attributes].empty?
  Chef::Log.info "Applying datacenter '#{datacenter[:id]}' attributes: #{datacenter[:attributes].inspect}"
  # it is important that we merge this with node[:override], as these (normal) attributes would
  # be kept, if this node would be moved to another DC where this attribute is not set
  node.override = Chef::Mixin::DeepMerge.deep_merge!(node.override, datacenter[:attributes])
end

#################
# cookbooks
#################
unless datacenter[:cookbooks].nil?
  datacenter[:cookbooks].each do |cb|
    Chef::Log.info "Applying datacenter '#{datacenter[:id]}' cookbook #{cb}"
    include_recipe cb
  end
end

#################
# label myself to make me searchable
#################
node.set[:datacenter] = datacenter[:id]

include_recipe "#{cookbook_name}::_production" if datacenter