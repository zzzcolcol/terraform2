variable "aws_region" {
    description = "region 입력"
    type = string
    default = "ap-northeast-2"
}

variable "vpc_cidr" {
    description = "vpc cidr block : 입력"
    type = string
}

variable "public_subnets" {
    description = "public subnet cidr block : 입력"
    type = list(string)
}

variable "private_subnets" {
    description = "private subnet cidr block : 입력"
    type = list(string)
  
}


variable "cluster_name" {
    description = "eks cluster name : 입력"
    type = string
  
}

variable "availability_zones" {
  description = "사용할 가용 영역 목록"
  type        = list(string)
}

