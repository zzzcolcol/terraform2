# VPC CIDR 블록
variable "vpc_cidr" {
  description = "VPC의 CIDR 블록"
  type        = string
}

variable "vpc_name" {
  description = "vpc name : 입력"
  type = string
  default = "eks-vpc"
}


# 퍼블릭 서브넷 CIDR 목록
variable "public_subnets" {
  description = "퍼블릭 서브넷의 CIDR 블록 목록"
  type        = list(string)
}

# 프라이빗 서브넷 CIDR 목록
variable "private_subnets" {
  description = "프라이빗 서브넷의 CIDR 블록 목록"
  type        = list(string)
}

# 가용 영역 리스트
variable "availability_zones" {
  description = "VPC에서 사용할 가용 영역 목록"
  type        = list(string)
}

# NAT Gateway 활성화 여부
variable "enable_nat_gateway" {
  description = "NAT Gateway 활성화 여부"
  type        = bool
  default     = true
}

# 인터넷 게이트웨이 사용 여부
variable "enable_internet_gateway" {
  description = "인터넷 게이트웨이 활성화 여부"
  type        = bool
  default     = true
}

# 태그 설정
variable "vpc_tags" {
  description = "VPC에 적용할 태그 목록"
  type        = map(string)
  default     = {
    "Environment" = "dev"
    "Project"     = "eks-cluster"
  }
}

variable "subnet_tags" {
  description = "서브넷에 적용할 태그 목록"
  type        = map(string)
  default     = {
    "Type" = "subnet"
  }
}

