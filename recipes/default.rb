#
# Cookbook Name:: aggregator
# Recipe:: default
#
# Copyright (C) 2014 PE, pf.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
node.default['iproute2']['start'] = []
node.default['iproute2']['stop']  = []

begin
  raise unless iproute2Definition = data_bag_item('clusters', node['fqdn'].gsub(".", "_"))
  rescue Exception
    puts '********************************************************************'
    puts 'This node name is not defined for such a role (procedure aborted)...'
    puts '********************************************************************'
  return 1
  ensure
  #
end

if iproute2Definition && iproute2Definition['iproute2']
  iproute2Definition = iproute2Definition['iproute2']
  iproute2Definition['stop'].each do |i|
    node.default['iproute2']['stop'].push(i)
  end

  iproute2Definition['start'].each do |i|
    node.default['iproute2']['start'].push(i)
  end
end

include_recipe 'chef-iproute2::default'
