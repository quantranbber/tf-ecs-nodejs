variable "vpcId" {
  type    = string
  default = "vpc-0e7816f0e046b9147"
}

variable "subnetIds" {
  type    = list(string)
  default = ["subnet-08153784a60861e05", "subnet-01ac7cf4b3a68be83"]
}

variable "sgId" {
  type    = string
  default = "sg-0e104a41303bf1e8d"
}

variable "imageRepo" {
  type    = string
  default = "946548608434.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-test:latest"
}