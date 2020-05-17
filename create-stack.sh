#!/usr/bin/env bash
stack_name=${1}
template_path=${2}
s3_bucket=${3}

aws cloudformation package --template-file ${template_path} --s3-bucket ${s3_bucket} --output-template-file ${stack_name}.yaml
aws cloudformation deploy --stack-name ${stack_name} --template-file ${stack_name}.yaml --capabilities CAPABILITY_NAMED_IAM
