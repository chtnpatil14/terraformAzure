### example on local 

# locals {
#   resource_name = "chetan"
# }
#Example 2:

# locals {
#   resource_name = "chhota"
# }

# resource "azurerm_resource_group" "example" {
#   name     = "${local.resource_name}-${count.index}"
#   location = "West Europe"
#   count = 5
# }

provider "azurerm" {
    features {}
  }


resource "azurerm_resource_group" "example" {
   name     = "datarg"
   location = "east us"
 }

# resource "azurerm_public_ip" "example" {
#   name                = "${local.resource_name}-pip"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   allocation_method   = "Static"
# }

#Example 3:

locals {
  nsg_rule = "rule"
  number = 10
  port = ["22","80","443","8080"]
}

resource "azurerm_network_security_group" "example" {
  count = length(local.port)
  name                = "NSG_local"
  location            = "eastus"
  resource_group_name = "datarg"
  security_rule {
    name                       = "${local.nsg_rule}-${count.index}"
    priority                   =  "${local.number}${count.index + 1}"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = local.port[count.index]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
