
default['dsi-db']['hosts'] = []
default['dsi-db']['listen'] = '0.0.0.0'

# Configuration de la VIP (KEEPALIVED)
#
default['dsi-db']['vip'] = '172.28.128.3'
default['dsi-db']['bind'] = 'eth1'
default['dsi-db']['keypass'] = 'secret'

default['dsi-db']['members'] = []