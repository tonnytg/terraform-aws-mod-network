# terraform-mod-network
Modulo Terraform para construção de uma rede


### Variaveis que você precisa definir para utilizar esse modulo
Já deixamos definido por padrão o CIDR_BLOCK com 10.0.0.0/16
Temos que definir CIDR para a VPC que você quer usar
`cidr_block`

Definimos o Range para Public 10.0.1.0/24
Temos que definir o range de IPs publicos
`cidr_blocks_pub`


Definimos o Range para Privado 10.0.2.0/24
Temos que definir o range de IPs privados
`cidr_blocks_pri`
