output "webserver_ip"{
    description = " ip address od my webserver"
    value=aws_instance.webserver.public_ip
}