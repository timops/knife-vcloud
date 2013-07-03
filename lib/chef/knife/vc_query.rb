#
# Author:: Tim Green (<tgreen@opscode.com>)
# Copyright:: Copyright (c) 2012
# License:: Apache License, Version 2.0
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

require 'chef/knife/vc_common'

class Chef
  class Knife
    class VcLogin < Chef::Knife
      include Knife::VcCommon

      banner "knife vc query [objtype] [filter]"

      def run
        $stdout.sync = true

        obj_type = @name_args.shift
        filter = @name_args.shift

        rsp = connection.packaged_query(obj_type, "fields=name,href?name=#{filter}")

        puts rsp
      end
    end
  end
end
