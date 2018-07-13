KUBERNETES_VERSION ?= 1.10.3
DATE ?= $(shell date +%Y-%m-%d)
# Defaults to Amazon Linux 2 LTS Candidate AMI
# Customize to CentOS AMI
#SOURCE_AMI_ID ?= ami-8c3848f4
SOURCE_AMI_ID ?= ami-9887c6e7

all: ami

ami:
	packer build -var source_ami_id=$(SOURCE_AMI_ID) eks-worker-centos.json

release:
	aws s3 cp ./amazon-eks-nodegroup.yaml s3://amazon-eks/$(KUBERNETES_VERSION)/$(DATE)
	@echo "Update CloudFormation link in docs at"
	@echo " - https://github.com/awsdocs/amazon-eks-user-guide/blob/master/doc_source/launch-workers.md"
	@echo " - https://github.com/awsdocs/amazon-eks-user-guide/blob/master/doc_source/getting-started.md"
