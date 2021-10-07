
variable "user_name" {
  default = "ubuntu"
}
variable "ssh_public_key" {
  default = "~/.ssh/public-aws"
}
variable "ssh_private_key" {
  default = "~/.ssh/my-aws-keys.pem"
}

variable "secret_azure" {
  default = "secret.azure"
}

variable "redmine_up_script" {
  default = "up_srcipts/redmine-ruby-start.sh"
}

variable "db_up_script" {
  default = "up_srcipts/postgresql-start.sh"
}
//Database
variable "db_adapter" {
  default ="postgresql"
}
variable "db_name" {
  default ="redmine"
}
variable "db_user_name" {
  default ="redmine"
}
variable "db_password" {
  default ="db_pass"
}
variable "id_client" {
  default ="id_client.azure"
}
variable "tenant_id" {
  default ="tenant_id.azure"
}
variable "subscription_id" {
  default ="subscription_id.azure"
}