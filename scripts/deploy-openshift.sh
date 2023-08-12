#!/bin/bash

if [ ! -f ~/.ssh/cluster-key ];
then
  echo "Creating ssh key"
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/cluster-key -N ''

  chmod 400 ~/.ssh/cluster-key.pub
  cat  ~/.ssh/cluster-key.pub
fi

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/cluster-key 

read -p "Enter the Base Domain: " BASE_DOMAIN
read -p "Enter the Pull Secret: " PULL_SECRET

if [ ! -d $HOME/cluster ]; then
    mkdir -p $HOME/cluster
fi

cat >$HOME/cluster/install-config.yaml << EOF
apiVersion: v1
metadata:
  name: 'industrial-edge'
baseDomain: '${BASE_DOMAIN}'
controlPlane:
  hyperthreading: Enabled
  name: master
  replicas: 3
  platform:
    aws:
      rootVolume:
        iops: 4000
        size: 100
        type: io1
      type: m5.2xlarge
compute:
- hyperthreading: Enabled
  name: 'worker'
  replicas: 3
  platform:
    aws:
      rootVolume:
        iops: 2000
        size: 100
        type: io1
      type:  m5.2xlarge
networking:
  networkType: OVNKubernetes
  clusterNetwork:
  - cidr: 10.128.0.0/14
    hostPrefix: 23
  machineNetwork:
  - cidr: 10.0.0.0/16
  serviceNetwork:
  - 172.30.0.0/16
platform:
  aws:
    region: us-east-2
pullSecret: '${PULL_SECRET}'
sshKey: "$(cat ~/.ssh/cluster-key.pub)"
EOF

openshift-install create cluster --dir $HOME/cluster --log-level debug
