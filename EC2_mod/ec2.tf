

resource "aws_instance" "webserver" {
    
ami=local.Amazon_Linux_ID
instance_type= local.instace_type
subnet_id=var.subnet_id
associate_public_ip_address =true
user_data_replace_on_change=true

vpc_security_group_ids =[aws_security_group.webserver_sg.id]
key_name = local.my_instance_key_name

user_data=templatefile(local.User_script_path,local.User_script_keys)
root_block_device {
    delete_on_termination= true
}





tags={
    Name="Terraform_Project_webserver"
  

}
}
###fixa securty groups: done
## koppla dem til ec2: done
## fixa storage : done 
# skapa en key pair: done 
# koppla keypair till ec2: done 
#userscript
#install wordpress done
#install maria db done
# creat a secure password aka use sensitve and varible done
# creat db, connect to user done 
# configure wordpress to your db done 
# creat user/data error den kördes aldrig kolla up cloadinit vad gick fel goola 
# kolla up df search do kan hjälpa userscript !
#user script done screnna 
# gör wizard för att fixa sidan !
# error din root password måste va fixad !!!! de därför wizard inte funkar 


resource "aws_security_group"  "webserver_sg" {  
    name= "Webserver_sg"
    description= "Security group for webserver"
    vpc_id=var.vpc_id
   
}


resource "aws_vpc_security_group_ingress_rule"  "allow_http"{
    security_group_id=aws_security_group.webserver_sg.id
    cidr_ipv4=local.allow_all_cidr 
    from_port=80
    to_port=80
   ip_protocol="tcp" 

}

resource "aws_vpc_security_group_ingress_rule"  "allow_https"{
    security_group_id=aws_security_group.webserver_sg.id
    cidr_ipv4=local.allow_all_cidr 
    from_port=443
    to_port=443
   ip_protocol="tcp" 

}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh"{
  security_group_id=aws_security_group.webserver_sg.id
    cidr_ipv4=local.MY_IP 
    from_port=22
    to_port=22
   ip_protocol="tcp" 

}

resource "aws_vpc_security_group_egress_rule"  "allow_http"{
    security_group_id=aws_security_group.webserver_sg.id
    cidr_ipv4=local.allow_all_cidr 
    from_port=80
    to_port=80
   ip_protocol="tcp" 

}

resource "aws_vpc_security_group_egress_rule"  "allow_https"{
    security_group_id=aws_security_group.webserver_sg.id
    cidr_ipv4=local.allow_all_cidr 
    from_port=443
    to_port=443
   ip_protocol="tcp" 

}
resource "aws_vpc_security_group_egress_rule"  "allow_ssh"{
    security_group_id=aws_security_group.webserver_sg.id
    cidr_ipv4=local.allow_all_cidr 
    from_port=22
    to_port=22
   ip_protocol="tcp" 
}

## chose an exitig key pair beacse its more secure building it in aws, terrfroms way tls resouce will create a new key pair and store the private key in a local state file unencrypted, which is not secure.


