PROJECT =
ENVNAME = nonprod
COMPONENT =
CUSTOMER =

.PHONY: clean init plan apply destroy boostrap pull-secrets push-secrets state secrets

SHELL = /bin/bash

TFSTATEBUCKET = ${PROJECT}-${ENVNAME}-tfstate
TFPLANFILE = ${PROJECT}-$(subst /,-,${COMPONENT}).tfplan

export TF_IN_AUTOMATION = 1

# bootstrap: state secrets

# state:
# 	@gsutil mb -p ${PROJECT} gs://${PROJECT}-${ENVNAME}-tfstate

# secrets:
# 	@gsutil mb -p ${PROJECT} gs://${PROJECT}-${ENVNAME}-tfsecrets
# 	@touch core/vars/${ENVNAME}.tfsecrets && gsutil cp core/vars/${ENVNAME}.tfsecrets gs://${PROJECT}-${ENVNAME}-tfsecrets/core/${ENVNAME}.tfsecrets
# 	@touch vpc/vars/${ENVNAME}.tfsecrets && gsutil cp vpc/vars/${ENVNAME}.tfsecrets gs://${PROJECT}-${ENVNAME}-tfsecrets/vpc/${ENVNAME}.tfsecrets
# 	@touch gke/vars/${ENVNAME}.tfsecrets && gsutil cp gke/vars/${ENVNAME}.tfsecrets gs://${PROJECT}-${ENVNAME}-tfsecrets/gke/${ENVNAME}.tfsecrets
# 	@touch iam/vars/${ENVNAME}.tfsecrets && gsutil cp iam/vars/${ENVNAME}.tfsecrets gs://${PROJECT}-${ENVNAME}-tfsecrets/iam/${ENVNAME}.tfsecrets

# pull-secrets:
# 	@gsutil cp gs://${PROJECT}-${ENVNAME}-tfsecrets/${COMPONENT}/${ENVNAME}.tfsecrets ${COMPONENT}/vars/${ENVNAME}.tfsecrets

# push-secrets:
# 	@gsutil cp ${COMPONENT}/vars/${ENVNAME}.tfsecrets gs://${PROJECT}-${ENVNAME}-tfsecrets/${COMPONENT}/${ENVNAME}.tfsecrets

clean:
	@rm -rf .terraform *.tfplan

init: clean
	@terraform init -backend-config bucket=${TFSTATEBUCKET} -backend-config prefix=${COMPONENT} ${COMPONENT}

plan: init
	@terraform plan -out ${TFPLANFILE} -var "project_id=${PROJECT}" -var-file=vars/${ENVNAME}.tfvars ${COMPONENT}

apply:
	@terraform apply ${TFPLANFILE}
	@rm -f ${TFPLANFILE}
	@if [ $(COMPONENT) == 'gke' ]; then \
	gcloud container clusters get-credentials k1; \
	fi

destroy: init
	@terraform destroy -var "project_id=${PROJECT}" -var-file=vars/${ENVNAME}.tfvars ${COMPONENT}
	@rm -f ${TFPLANFILE}
