# demo.redhat.com Deployment

The following instructions will deploy the industrial edge demo on demo.redhat.com.

DEMOS: https://validatedpatterns.io/patterns/industrial-edge/application/


1. [Configure your bastion host to deploy OpenShift](deploy-openshift.md)

2. Configure prerequisites scripts
```
$ curl -OL https://raw.githubusercontent.com/tosin2013/industrial-edge/main/scripts/step1-configure-env.sh
$ chmod +x step1-configure-env.sh
$ ./step1-configure-env.sh
```

### TO-DO Automate the following steps
* https://github.com/validatedpatterns/industrial-edge.git
* https://github.com/validatedpatterns-demos/manuela-dev.git

4. Configure Gitea Enviornment

*Register Account*
![20230811213652](https://i.imgur.com/LD1vsNx.png)

*Migrate Repos*
![20230811213736](https://i.imgur.com/ZU5lbhX.png)

*Click on Git*
![20230811213807](https://i.imgur.com/VPl4oTW.png)

*Import industrial-edge repo*
* https://github.com/validatedpatterns/industrial-edge.git
![20230811214001](https://i.imgur.com/6c1pd2j.png)
![20230811213850](https://i.imgur.com/VLeD1GQ.png)

*Import manuela-dev repo*
* https://github.com/validatedpatterns-demos/manuela-dev.git
![20230811214136](https://i.imgur.com/a1gCIjt.png)
![20230811214312](https://i.imgur.com/bgQEYEg.png)

*Create Git Token `industrial-edge-token`*
![20230811214545](https://i.imgur.com/6cIfTeI.png)
![20230811214607](https://i.imgur.com/sKV50i1.png)

5. Configure Quay Enviornment
*Create Quay Account*
![20230811214919](https://i.imgur.com/echuhXq.png)
*Create Robot user*
![20230811214958](https://i.imgur.com/U30z0zM.png)
![20230811215022](https://i.imgur.com/o0lpazS.png)
*industrialedge*
![20230811215124](https://i.imgur.com/PJV23N5.png)
*Create Repos*
* your-org/iot-software-sensor
* your-org/iot-consumer
* your-org/iot-frontend
* your-org/iot-anomaly-detection
* your-org/http-ionic


*Each one should be public*
![20230811215254](https://i.imgur.com/HkDwf96.png)
![20230811215434](https://i.imgur.com/jLKHUrJ.png)

6. Generate .env file
```
$ curl -OL https://raw.githubusercontent.com/tosin2013/industrial-edge/main/scripts/generate-env.py
$ python3 generate-env.py
```

Example Inputs:
```
$ python3 generate-env.py
Your Git URL: https://gitea-with-admin-gitea.apps.mllearning.XXXX.example.com/user1/industrial-edge
Your quay robot account username: user1+industrialedge
Your quay robot account password: 
Your Git username: user1
Your Git token: 
Your AWS access key ID: XXXXXXXXX
Your AWS secret access key: 
Your Git account: user1
Your image registry account: user1
Your image registry hostname: quay-registry-quay-quay-registry.apps.mllearning.XXXX.example.com
Your S3 bucket region: us-east-2
Your S3 bucket name: industrial-edge-$GUID
Your Git hostname: gitea-with-admin-gitea.apps.mllearning.XXXX.example.com
Your version [v2.3]: 

$ cat .env
```

7. Deploy the industrial edge demo
```
$ curl -OL https://raw.githubusercontent.com/tosin2013/industrial-edge/main/scripts/step2-deploy-industrial-edge.sh
$ chmod +x step2-deploy-industrial-edge.sh
$ ./step2-deploy-industrial-edge.sh
```

