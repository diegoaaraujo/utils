#!/bin/bash


accounts=(jason-account1 jason-account2 jason-account3 jason-account4)

for account in ${accounts[@]}
	do
		echo "changing password for $account"
		aws iam change-password --cli-input-json file://change-password.json --profile $account
	done
