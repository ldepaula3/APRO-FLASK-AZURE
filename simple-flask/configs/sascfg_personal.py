SAS_config_names   = ['ssh']
ssh                = {'saspath'  : '/opt/sas/viya/home/SASFoundation/sas',
                      'ssh'      : '/usr/bin/ssh',
                      'host'     : '172.17.0.2', # sas apro container host
                      'luser'    : 'sasdemo',
                      'localhost': '172.17.0.3', # local Python container ip address
                      'options'  : ["-fullstimer"]
                     }