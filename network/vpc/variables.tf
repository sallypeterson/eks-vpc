variable "name" {
  type        = string
  description = "vpc name"
}

variable "vpc_cidr" {
  type    = string
  default = "vpc cidr"
}

variable "azs" {
  type        = list(string)
  description = "list of azs"
}

variable "private_subnets" {
  type        = list(string)
  description = "list of private subnet cidrs"
}

variable "public_subnets" {
  type        = list(string)
  description = "list of public subnet cidrs"
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
  description = "enable dns hostnames"
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "enable dns support"
}

variable "manage_default_security_group" {
  type        = bool
  default     = true
  description = "managed default sg"
}

variable "default_security_group_egress" {
  type        = any
  default     = []
  description = "default sg egress"
}

variable "default_security_group_ingress" {
  type        = any
  default     = []
  description = "default sg ingress"
}

variable "map_public_ip_on_launch" {
  type        = bool
  default     = false
  description = "public ip on launch"
}

variable "private_subnet_tags" {
  type = map(any)
  default = {
    "kubernetes.io/role/internal-elb" = 1
  }
  description = "private subnet tags"
}

variable "public_subnet_tags" {
  type = map(any)
  default = {
    "kubernetes.io/role/elb" = 1
  }
}

variable "enable_nat_gateway" {
  type        = bool
  default     = true
  description = "nat gateway enabled"
}

variable "single_nat_gateway" {
  type        = bool
  default     = false
  description = "single nat "
}

variable "one_nat_gateway_per_az" {
  type        = bool
  default     = true
  description = "per az nat"
}

variable "enable_flow_log" {
  type        = bool
  default     = true
  description = "flow logs"
}

variable "flow_log_destination_type" {
  type        = string
  default     = "s3"
  description = "flow log destination type"
}

variable "flow_log_destination_arn" {
  type        = any
  default     = null
  description = "flow log destination arn"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "tags"
}

