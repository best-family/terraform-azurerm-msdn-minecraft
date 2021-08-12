# References to this backend can be made using the following example code.
# https://www.terraform.io/docs/providers/terraform/d/remote_state.html

data "terraform_remote_state" "msdn-networking" {
  backend = "remote"

  config = {

    organization = "BestFamily"
    workspaces = {
      name = "msdn-networking-${var.ENVIRONMENT}"
    }

    hostname = "app.terraform.io"
  }
}

data "terraform_remote_state" "terraform-azurerm-msdn-dns" {
  backend = "remote"

  config = {

    organization = "BestFamily"
    workspaces = {
      name = "terraform-azurerm-msdn-dns"
    }

    hostname = "app.terraform.io"
  }
}
