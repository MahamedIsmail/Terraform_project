variable "subnet_id" {
    description= "The ID of the subnet "
    type= string 
  
}
variable "vpc_id" {
    description= "The id of vpc"
    type = string 
}

variable "IP_address" {
    description= "The IP address of the machine"
    type = string 
}

variable "Database_name" {
    description = "Maria_db database name"
    type= string
    sensitive = true
}

variable "Database_User_name" {
    description = "Maria_db username"
    type= string
    sensitive = true
}

variable "Database_User_password" {
    description = "Maria_db user password"
    type= string
    sensitive = true
}

variable "Host_name" {
    description = "where Maria_db user connects to databse from"
    type= string
    default = "localhost"
}



variable "Databas_root_password" {
    description = "Maria_db user password"
    type= string
    sensitive = true
}

