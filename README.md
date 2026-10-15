# Terraform on AWS – Infrastructure as Code Projects

Two hands-on assignments where AWS infrastructure is built entirely from code with Terraform. One `terraform apply` creates the network and server and configures the software on first boot, with no clicking in the AWS console and no manual SSH setup.

|  | [Assignment 1](./ASG1/README.md) | [Assignment 2](./ASG2/README.md) |
|---|---|---|
| **Goal** | Deploy a full WordPress stack | Deploy an NGINX web server |
| **Bootstrapping** | Bash user data script, rendered with `templatefile()` | `#cloud-config` YAML file |
| **Result** | Live WordPress site with working admin dashboard | Custom website served by NGINX |
| **Terraform structure** | Root module (network) + EC2 child module | Root module + EC2 child module |

---

## [Assignment 1 – Automated WordPress Deployment](./ASG1/README.md)

Terraform builds a VPC, public subnet, internet gateway, route table and security groups, then launches an EC2 instance whose user data script installs and configures Apache, PHP, MariaDB and WordPress in five phases.

**Highlights**
- Root module builds the network and passes values into an EC2 module through variables and outputs
- Database credentials injected with `templatefile()`, marked `sensitive` and kept out of Git
- `user_data_replace_on_change` so script changes rebuild the instance
- SSH limited to my IP, database user restricted to `localhost`

**Problems solved:** security group blocking HTTPS package downloads, interactive `mysql` and `nano` breaking automation, editing `wp-config.php` with `sed`, and Terraform module output references.
→ [Read the troubleshooting](./ASG1/README.md#problems-i-hit-and-how-i-fixed-them)

## [Assignment 2 – EC2 Deployment with cloud-init](./ASG2/README.md)

Terraform passes a cloud-init file to EC2 as user data. On first boot, cloud-init installs NGINX, writes the web page and site config, validates the config and starts the service, so the website is live with no manual steps.

**Highlights**
- Declarative configuration with cloud-init modules (`packages`, `write_files`, `runcmd`)
- `defer: true` so files are written after NGINX is installed
- Config validated with `cloud-init schema` and `nginx -t`
- Written comparison of cloud-config versus plain bash user data

**Problems solved:** YAML list and indentation errors, a duplicated `write_files` key silently overwriting files, invalid NGINX syntax, and NGINX serving its default page, diagnosed through response sizes in the access log.
→ [Read the trial and error](./ASG2/README.md#trial-and-error) · [Why cloud-config over bash](./ASG2/README.md#why-cloud-config-instead-of-a-plain-user-data-script)

---

## Skills demonstrated

- **Infrastructure as Code:** Terraform modules, variables, outputs, locals, `templatefile()`, sensitive values
- **AWS:** VPC, subnets, internet gateway, route tables, security groups, EC2
- **Server automation:** Bash user data, cloud-init, YAML
- **Web stack:** NGINX, Apache, PHP, MariaDB, WordPress on Amazon Linux 2023
- **Security:** least-privilege access, secrets and state kept out of Git
- **Troubleshooting:** cloud-init logs, schema validation, NGINX access logs, debugging over SSH

## Tech stack

Terraform · AWS · cloud-init · Bash · YAML · NGINX · Apache · PHP · MariaDB · WordPress · Amazon Linux 2023