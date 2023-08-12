#!/bin/bash
set -x
# oc apply -k https://github.com/tosin2013/sno-quickstarts/gitops/cluster-config/openshift-data-foundation-operator/operator/overlays/stable-4.13
# oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-container-storage-noobaa/overlays/default
# oc apply -k https://github.com/tosin2013/sno-quickstarts/gitops/cluster-config/quay-registry-operator/operator/overlays/stable-3.8
# oc apply -k https://github.com/tosin2013/sno-quickstarts/gitops/cluster-config/quay-registry-operator/instance/overlay/default

# Replace these variables with your actual values
if [ -f ~/.env ]; then
   source ~/.env
else
   echo ".env file not found in home directory. Please create one and try again."
   exit $? 
fi

# Clone the industrial-edge repository and create a deployment branch
if [ ! -d $HOME/industrial-edge ]; then
    git clone ${YOUR_GIT_URL}
fi 

cd industrial-edge
git checkout ${YOUR_VERSION}
git switch -c deploy-${YOUR_VERSION}

# Create a values-secret-industrial-edge.yaml file and customize the secret values using sed
cp values-secret.yaml.template ~/values-secret-industrial-edge.yaml

# Customize the secret values using sed
sed -i "s/<Your-Robot-Account>/$YOUR_ROBOT_ACCOUNT_USERNAME/" ~/values-secret-industrial-edge.yaml
sed -i "s/<Your-RobotAccount-Password>/$YOUR_ROBOT_ACCOUNT_PASSWORD/" ~/values-secret-industrial-edge.yaml
sed -i "s/<github-user>/$YOUR_GITHUB_USERNAME/" ~/values-secret-industrial-edge.yaml
sed -i "s/<github-token>/$YOUR_GITHUB_TOKEN/" ~/values-secret-industrial-edge.yaml
sed -i "s/<AWS-Access-Key-ID>/$YOUR_AWS_ACCESS_KEY_ID/" ~/values-secret-industrial-edge.yaml
sed -i "s/<AWS-Secret-Access-Key>/$YOUR_AWS_SECRET_ACCESS_KEY/" ~/values-secret-industrial-edge.yaml

# Customize the deployment for your cluster using sed
sed -i "s/datacenter/$YOUR_CLUSTER_GROUP_NAME/" values-global.yaml
sed -i "s/industrial-edge/$YOUR_GLOBAL_PATTERN/" values-global.yaml
sed -i "s/False/true/" values-global.yaml
sed -i "s/Automatic/Semi-Automatic/" values-global.yaml
sed -i "s/Automatic/Manual/" values-global.yaml
sed -i "s/quay.io/$YOUR_IMAGEREGISTRY_HOSTNAME/" values-global.yaml
sed -i "s/quay/$YOUR_IMAGEREGISTRY_TYPE/" values-global.yaml
sed -i "s/github.com/$YOUR_GIT_HOSTNAME/" values-global.yaml
sed -i "s/main/$YOUR_DEV_REVISION/" values-global.yaml
sed -i "s/BUCKETNAME/$YOUR_S3_BUCKET_NAME/" values-global.yaml
sed -i "s/AWSREGION/$YOUR_S3_BUCKET_REGION/" values-global.yaml

yq e -i '.global.imageregistry.account = "'$YOUR_IMAGEREGISTRY_ACCOUNT'"' values-global.yaml
yq e -i '.global.git.account = "'$YOUR_GIT_ACCOUNT'"' values-global.yaml



git pull origin deploy-${YOUR_VERSION}
git add values-global.yaml
git commit -m "Added personal values"
git push origin deploy-${YOUR_VERSION}


# Deploy the pattern
./pattern.sh make install
