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
  apt_repository "squeeze-lts" do
    uri "http://http.debian.net/debian/"
    distribution "squeeze-lts"
    components ['main', 'contrib', 'non-free']
    action :add
  end
end
