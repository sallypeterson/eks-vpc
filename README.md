# eks-vpc

## How to deploy

### create network (vpc, subnets, etc)
```bash
cd network
terrafrom init
terraform plan
terraform apply
```

### create eks cluter
```bash
cd k8s
terraform init
terraform plan
terraform apply
```