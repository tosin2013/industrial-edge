# Configure your bastion host to deploy OpenShift

1. Setup bastion node on AWS
2. Configure AWS CLI
```
curl -OL https://raw.githubusercontent.com/tosin2013/openshift-4-deployment-notes/master/aws/configure-aws-cli.sh
chmod +x configure-aws-cli.sh 
./configure-aws-cli.sh -i aws_access_key_id aws_secret_access_key aws_region
```

3. Configure OpenShift Packages 
```
curl -OL https://raw.githubusercontent.com/tosin2013/openshift-4-deployment-notes/master/pre-steps/configure-openshift-packages.sh
chmod +x configure-openshift-packages.sh
export VERSION=latest-4.12
./configure-openshift-packages.sh -i
```

4. Deploy OpenShift
```
curl -OL https://raw.githubusercontent.com/tosin2013/openshift-4-deployment-notes/master/pre-steps/deploy-openshift.sh
chmod +x deploy-openshift.sh
./deploy-openshift.sh
```

5. Configure Certs for OpenShift
* https://docs.openshift.com/container-platform/4.12/security/certificates/replacing-default-ingress-certificate.html
* https://gist.github.com/tosin2013/866522a1420ac22f477d2253121b4416