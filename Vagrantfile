# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
VAGRANT_BOX = 'ubuntu-14.04-chef'
Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.include_offline = true
  config.vm.define 'db1' do |queue|
    queue.vm.hostname = 'db1'
    queue.vm.box = VAGRANT_BOX
    queue.vm.network 'private_network', ip: '172.28.128.4'
    queue.berkshelf.enabled = true
    queue.vm.provision :chef_solo do |chef|
      chef.json = {
      }
      chef.run_list = [
        'recipe[dsi-db::default]'
      ]
    end
  end

  config.vm.define 'db2' do |queue|
    queue.vm.hostname = 'db2'
    queue.vm.box = VAGRANT_BOX
    queue.vm.network 'private_network', ip: '172.28.128.5'
    queue.berkshelf.enabled = true
    queue.vm.provision :chef_solo do |chef|
      chef.json = {
      }
      chef.run_list = [
        'recipe[dsi-db::default]'
      ]
    end
  end

  config.vm.define 'db3', autostart: false do |queue|
    queue.vm.hostname = 'db3'
    queue.vm.box = VAGRANT_BOX
    queue.vm.network 'private_network', ip: '172.28.128.6'
    queue.berkshelf.enabled = true
    queue.vm.provision :chef_solo do |chef|
      chef.json = {
      }
      chef.run_list = [
        'recipe[dsi-db::default]'
      ]
    end
  end

  config.vm.define 'db4', autostart: false do |queue|
    queue.vm.hostname = 'db4'
    queue.vm.box = VAGRANT_BOX
    queue.vm.network 'private_network', ip: '172.28.128.7'
    queue.berkshelf.enabled = true
    queue.vm.provision :chef_solo do |chef|
      chef.json = {
      }
      chef.run_list = [
        'recipe[dsi-db::default]'
      ]
    end
  end
end
