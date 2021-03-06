#
# Author:: Stefano Tortarolo (<stefano.tortarolo@gmail.com>)
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
    class VcVappCreate < Chef::Knife
      include Knife::VcCommon

      banner "knife vc vapp create [VDC_NAME] [NAME] [DESCRIPTION] [TEMPLATE_NAME] (options)"

      option :start_vapp,
             :short => "-S",
             :long => "--start",
             :boolean => true,
             :description => "Start vApp after creation"

      def run
        $stdout.sync = true

        vdc_id = @name_args.shift
        name = @name_args.shift
        description = @name_args.shift
        templateId = @name_args.shift

        connection.login

        vapp_id, task_id = connection.create_vapp_from_template vdc_id, name, description, templateId

        print "vApp creation..."
        wait_task(connection, task_id)
        puts "vApp created with ID: #{ui.color(vapp_id, :cyan)}"

        if config[:start_vapp]
          connection.poweron_vapp(vapp_id)
          puts "\nvApp [ #{name} : #{ui.color(vapp_id, :cyan)} ] started."
        end

        connection.logout
      end
    end
  end
end
