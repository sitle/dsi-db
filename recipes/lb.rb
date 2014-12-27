#
# Cookbook Name:: dsi-db
# Recipe:: lb
#
# Copyright (C) 2014 Leonard TAVAE
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Configuration de la VIP (KEEPALIVED)
#
node.set['keepalived']['check_scripts']['chk_init'] = {
  script: 'killall -0 init',
  interval: 2,
  weight: 2
}

node.set['keepalived']['instances']['vi_1'] = {
  ip_addresses: node['dsi-db']['vip'],
  interface: node['dsi-db']['bind'],
  track_script: 'chk_init',
  nopreempt: false,
  advert_int: 1,
  auth_type: nil, # :pass or :ah
  auth_pass: node['dsi-db']['keypass']
}

include_recipe 'keepalived'

# Configuration de la repartition de charge (HAPROXY)
#
include_recipe 'haproxy::install_package'

template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[haproxy]'
end

template '/etc/default/haproxy' do
  source 'haproxy.default.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[haproxy]'
end

service 'haproxy' do
  supports restart: true, status: true, reload: true
  action [:enable, :start]
end