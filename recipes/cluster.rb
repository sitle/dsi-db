#
# Cookbook Name:: dsi-db
# Recipe:: cluster
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

# Configuration du cluster de database
#
cluster_ips = node['dsi-db']['hosts']
cluster_address = "gcomm://#{cluster_ips.join(',')}"
Chef::Log.info "Using Percona XtraDB cluster address of: #{cluster_address}"

node.set['percona']['cluster']['package'] = 'percona-xtradb-cluster-56'
node.set['percona']['apt_keyserver'] = 'keys.gnupg.net'
node.set['percona']['server']['binlog_format'] = 'ROW'

node.set['percona']['conf']['mysqld']['wsrep_cluster_address'] = cluster_address
node.set['percona']['conf']['mysqld']['wsrep_node_name'] = node['hostname']
node.set['percona']['conf']['mysqld']['wsrep_node_address'] = node['fqdn']
node.set['percona']['conf']['mysqld']['wsrep_provider'] = '/usr/lib/libgalera_smm.so'
node.set['percona']['conf']['mysqld']['wsrep_sst_method'] = 'rsync'
node.set['percona']['conf']['mysqld']['wsrep_sst_auth'] = 'root:'
node.set['percona']['server']['bind_address'] = node['dsi-db']['listen']
node.set['percona']['main_config_file'] = '/etc/mysql/my.cnf'

include_recipe 'percona::cluster'
include_recipe 'percona::backup'
include_recipe 'percona::toolkit'