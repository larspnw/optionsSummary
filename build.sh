#!/bin/sh 

sam build
if [ $? -ne 0 ]; then
	echo build failed
	exit 1
fi

sam package --output-template packaged.yaml --s3-bucket larsbucket1
if [ $? -ne 0 ]; then
	echo package failed
	exit 1
fi

sam deploy --template-file packaged.yaml --region us-east-1 --capabilities CAPABILITY_IAM --stack-name optionsSummary
if [ $? -ne 0 ]; then
	echo deploy failed
	exit 1
fi

echo SUCCESS
exit 0
