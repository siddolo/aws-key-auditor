# aws-key-auditor

##### Audit a compromised AWS key credentials

This simple script tests passed credentials against some read-only awscli commands.

If you have cowsay installed and you don't want cows, set environment variable USE_COWSAY to "no" :)

### Usage:
```
Usage ./aws_key_auditor.sh <AWS KEY> <AWS SECRET> <AWS REGION> [ACCOUNT ID]
Example: ./aws_key_auditor.sh AKIAIKAAAAAAAAAAAAAAQ 9aHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb eu-west-1
Example: ./aws_key_auditor.sh AKIAIKAAAAAAAAAAAAAAQ 9aHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAb eu-west-1 123456789012
```

### Example:
```
 ___________________________
< sts get-caller-identity:  >
 ---------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
{
    "UserId": "AI***********U",
    "Account": "77********5",
    "Arn": "arn:aws:iam::77********5:user/m.rossi@foobar.com"
}
[...]
 _____________________________
< ec2 describe-route-tables:  >
 -----------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
{
    "RouteTables": [
        {
            "Tags": [],
            "VpcId": "vpc-c3*****1",
            "Associations": [
                {
                    "RouteTableId": "rtb-80******2",
                    "RouteTableAssociationId": "rtbassoc-7******f",
                    "Main": true
                }
            ],
            "Routes": [
                {
                    "State": "active",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "DestinationCidrBlock": "172.31.0.0/16"
                },
                {
                    "State": "active",
                    "GatewayId": "igw-c******c",
                    "Origin": "CreateRoute",
                    "DestinationCidrBlock": "0.0.0.0/0"
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-80*****2"
        }
    ]
}
```
