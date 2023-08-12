# RHPDS Deployment


DEMOS: https://validatedpatterns.io/patterns/industrial-edge/application/


deploy-openshift.md

```
$ step1_configure_env.sh
```

### Automate 
* https://github.com/validatedpatterns/industrial-edge.git
* https://github.com/validatedpatterns-demos/manuela-dev.git

```
python3 scripts/generate-env.py
```

Example:
```
$ python3 test-script.py 
Your Git URL: https://gitea-with-admin-gitea.apps.mllearning.sandbox1847.opentlc.com/user1/industrial-edge
Your quay robot account username: user1+mlpipeline
Your quay robot account password: 
Your Git username: user1
Your Git token: 
Your AWS access key ID: XXXXXXXXX
Your AWS secret access key: 
Your Git account: user1
Your image registry account: user1
Your image registry hostname: quay-registry-quay-quay-registry.apps.mllearning.sandbox1847.opentlc.com
Your S3 bucket region: us-east-2
Your S3 bucket name: mlpipeline-gb4bw
Your Git hostname: gitea-with-admin-gitea.apps.mllearning.sandbox1847.opentlc.com
Your version [v2.3]: 

$ cat .env
```

```
scripts/quick-deploy.sh
```


fix values-global.yaml
```
  imageregistry:
    account: PLAINTEXT
    hostname: quay.io
    type: quay

  git:
    hostname: github.com
    account: PLAINTEXT
    #username: PLAINTEXT
    email: SOMEWHERE@EXAMPLE.COM
    dev_revision: main
```