locals{

     Amazon_Linux_ID ="ami-0b79f6b294a030f24"
     instace_type = "t3.micro"
     allow_all_cidr = "0.0.0.0/0"
     my_instance_key_name="wordpress_webserver_key"
     MY_IP=var.IP_address
     User_script_path= "${path.module}/User_data_script.sh"
     
      User_script_keys= {
      user=var.Database_User_name
      your_strong_password=var.Database_User_password
      hostname=var.Host_name
      Database_name=var.Database_name
      root_password=var.Databas_root_password

      }
    
}