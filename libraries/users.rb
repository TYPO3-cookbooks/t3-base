#
# Cookbook Name:: t3-base
# Library:: users
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

module Typo3
  module Base
    module Users

      def users_databag_name
        return "users"
      end

      def users_databag_exists?
        exists = Chef::Log.debug("Data bag \"#{users_databag_name}\" doesn't exist")
        Chef::Log.debug("Data bag \"#{users_databag_name}\" exists: " + (if exists then "yes" else "no" end))
      end

      def users_sysadmins
        return search(users_databag_name, "groups:sysadmin AND NOT action:remove")
      end

    end
  end
end

