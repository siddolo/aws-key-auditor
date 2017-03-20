#!/bin/bash
# Audit a compromised AWS account.
# This simple script tests passed credentials against some read-only awscli commands.
# If you have cowsay installed and you don't want cows, set environment variable USE_COWSAY to "no" :)
# 
# Pasquale 'sid' Fiorillo <info@pasqualefiorillo.it>

shopt -s expand_aliases

if [ "$#" -lt 3 ]; then
	>&2 echo -e "\nPost-compromised AWS account auditor."
	>&2 echo -e "AWS-CLI is required, Read <https://aws.amazon.com/documentation/cli/>\n"
	>&2 echo "Usage $0 <AWS KEY> <AWS SECRET> <AWS REGION> [ACCOUNT ID]"
	>&2 echo "Example: $0 AKIAIKAAAAAAAAAAAAAAQ 9aHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb eu-west-1"
	>&2 echo "Example: $0 AKIAIKAAAAAAAAAAAAAAQ 9aHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb eu-west-1 123456789012"
	exit 1
fi

if [ "$#" -eq 4 ]; then
	export AWS_ACCOUNT_ID=$4
fi

export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2
export AWS_DEFAULT_REGION=$3

cowsay test &> /dev/null

if [[ $? -eq 0 && $USE_COWSAY != "no" ]]; then
	alias out='cowsay'
	else
	alias out='echo -n'
fi

while read -r command
do 
	buffer=`aws ${command} 2> /dev/null`
	if [ $? -eq 0 ]; then
		out "${command}: "
		echo -e "${buffer}"
	fi
done <<'EOF'
sts get-caller-identity
sts get-session-token
acm list-certificates
apigateway get-account
autoscaling describe-auto-scaling-groups
cloudformation describe-stacks
cloudfront list-distributions
cloudhsm list-available-zones
cloudsearch list-domain-names
cloudtrail list-public-keys
cloudwatch list-metrics
codecommit list-repositories
codepipeline list-pipelines
cognito-identity list-identity-pools --max-results 10
configservice get-status
datapipeline list-pipelines
deploy list-applications
devicefarm list-devices
directconnect describe-locations
discovery describe-agents
dms describe-endpoints
ds describe-directories
dynamodb list-tables
ec2 describe-instances
ec2 describe-key-pairs
ec2 describe-route-tables
ec2 describe-network-acls
ecr get-login
ecs list-clusters
efs describe-file-systems
elasticache describe-cache-clusters
elastictranscoder list-pipelines
elb describe-load-balancers
emr list-clusters
es list-domain-names
events list-rules
firehose list-delivery-streams
gamelift list-builds
glacier list-vaults --account-id ${AWS_ACCOUNT_ID}
iam list-users
iam list-access-keys
iam list-groups
iam list-policies
importexport list-jobs
inspector list-assessment-targets
iot list-policies
kinesis list-streams
kms list-aliases
lambda list-functions
logs describe-log-groups
machinelearning describe-data-sources
rds describe-db-clusters
redshift describe-clusters
route53 list-hosted-zones
s3 ls
sdb list-domains
ses list-identities
sms get-connectors
snowball get-snowball-usage
sns list-subscriptions
sns list-topics
sqs list-queues
support describe-services
support describe-cases
waf list-rules
workspaces describe-workspaces
EOF
