
# eks cluster
module "my-eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "v17.22.0"

  cluster_name    = "my-eks"
  cluster_version = "1.21"

  vpc_id  = data.aws_vpc.my.id
  subnets = local.my_public_subnets

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  #cluster_endpoint_public_access_cidrs = ["trusted_ip",...]

  enable_irsa      = true
  write_kubeconfig = false

  map_roles = [
    {
      rolearn  = aws_iam_role.my_admin.arn
      username = "my-admin-role"
      groups   = ["system:masters"]
    }
  ]

  map_users = [
    {
      userarn = "arn:aws:iam::349501973693:user/sally"
      username = "sally"
      groups = ["system:masters"]
    },
    {
      userarn = "arn:aws:iam::349501973693:user/root"
      username = "root"
      groups = ["system:masters"]
    }
  ]

  node_groups_defaults = {
    ami_type   = "AL2_x86_64"
    disk_size  = 50
    k8s_labels = {}
    additional_tags = merge(local.tags, {
      nodegroup-role = "worker"
    })
    create_launch_template = true
  }

  node_groups = {
    mng_121 = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["m4.large"]
      subnets        = local.my_private_subnets
      k8s_labels     = {}
      additional_tags = {
        Name = "mng_121"
      }
      update_config = {
        max_unavailable_percentage = 50
      }
    }
  }
  tags = merge(local.tags, {
    Name = "my-eks"
  })

  depends_on = [
    aws_iam_role.my_admin
  ]
}

data "aws_eks_cluster" "my-eks" {
  name = module.my-eks.cluster_id
}

data "aws_eks_cluster_auth" "my-eks" {
  name = module.my-eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.my-eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.my-eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.my-eks.token
}