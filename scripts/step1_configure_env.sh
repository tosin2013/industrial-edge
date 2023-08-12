#!/bin/bash
function wait_for_pod() {
  local pod_name=$1
  local namespace=$2

while [[ $(oc get pods "$pod_name" -n "$namespace" -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do
    echo "Waiting for pod: $pod_name"
    sleep 5
  done
}


if [ -z "$1" ]; then
  echo "Error: openshift token is not passed."
  exit 1
fi

if [ -z "$2" ]; then
  echo "Error: openshift url is not passed."
  exit 1
fi

token=$1
url=$2

sudo yum install wget git python3-pip podman make -y
sudo pip3 install click 
#curl -OL https://raw.githubusercontent.com/tosin2013/openshift-4-deployment-notes/master/pre-steps/configure-openshift-packages.sh
#chmod +x configure-openshift-packages.sh
#./configure-openshift-packages.sh -i


echo "Logging in to OpenShift..."
oc login --token=$token --server=$url

if [ $? -ne 0 ]; then
  echo "Failed to login to OpenShift."
  exit 1
fi

echo "Successfully logged in to OpenShift."


oc apply -k https://github.com/tosin2013/sno-quickstarts/gitops/cluster-config/openshift-data-foundation-operator/operator/overlays/stable-4.12
phase=$(oc get csv -n  openshift-storage |grep odf-operator | grep Succeeded | awk '{print $7}')
# While the phase is not Succeeded, sleep for 10 seconds and then get the phase again
while [[ $phase != "Succeeded" ]]; do
  sleep 10
  phase=$(oc get csv -n  openshift-storage |grep odf-operator | grep Succeeded | awk '{print $7}')
done


oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-container-storage-noobaa/overlays/default
sleep 30s
NOOBA_POD=$(oc get pods -n openshift-storage | grep noobaa-core- | awk '{print $1}')
wait_for_pod $NOOBA_POD openshift-storage


oc apply -k https://github.com/tosin2013/sno-quickstarts/gitops/cluster-config/quay-registry-operator/operator/overlays/stable-3.8
phase=$(oc get csv |grep quay-operator | grep Succeeded | awk '{print $7}')
# While the phase is not Succeeded, sleep for 10 seconds and then get the phase again
while [[ $phase != "Succeeded" ]]; do
  sleep 10
  phase=$(oc get csv |grep quay-operator | grep Succeeded | awk '{print $7}')
done

oc apply -k https://github.com/tosin2013/sno-quickstarts/gitops/cluster-config/quay-registry-operator/instance/overlay/default
sleep 30s
QUAY_DB_POD=$(oc get pods -n quay-registry | grep quay-registry-quay-database- | awk '{print $1}')
wait_for_pod $QUAY_DB_POD quay-registry 
#QUAY_MIRROR_POD=$(oc get pods -n quay-registry | grep quay-registry-quay-mirror- | awk '{print $1}' | head -1)
#wait_for_pod $QUAY_MIRROR_POD quay-registry 

curl -OL https://raw.githubusercontent.com/tosin2013/openshift-demos/master/quick-scripts/deploy-gitea.sh
chmod +x deploy-gitea.sh
./deploy-gitea.sh