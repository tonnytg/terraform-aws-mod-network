# terraform-mod-network
Modulo Terraform para construção de uma rede


### Variaveis que você precisa definir para utilizar esse modulo
Já deixamos definido por padrão o CIDR_BLOCK com `10.0.0.0/16`

Temos que definir CIDR para a VPC que você quer usar
`cidr_block`

Definimos o Range para Public 10.0.1.0/24
Temos que definir o range de IPs publicos
`cidr_blocks_pub`


Definimos o Range para Privado 10.0.2.0/24
Temos que definir o range de IPs privados
`cidr_blocks_pri`


How to use:
```
module "vpc" {
  source = "git::github.com/tonnytg/terraform-mod-network?ref=v1.0-alpha"

  cidr   	  = "11.0.0.0/16"
  cidr_blocks_pub = ["11.0.1.0/24", "11.0.3.0/24"]
  cidr_blocks_pri = ["11.0.2.0/24", "11.0.4.0/24"]

  project_name = "test-main"
}
```
