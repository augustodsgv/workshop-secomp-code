# Terraform
Esse diretório contém a documentação e os arquivos necessários para fazer o deploy de recursos na Magalu Cloud usando a ferramenta Terraform.

## Como rodar
### Instalação do Terraform
[Terraform](https://developer.hashicorp.com/terraform) é uma ferramenta de Infraestrutura como Código (IAC - Infrastructure as Code) que permite o gerenciamento de recursos de provedores cloud por meio de código.

Para usar o Terraform, primeiramente siga a documentação com as [instruções de download](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

### Criação da API key
Para usar o Terraform, é preciso autenticar-se no provedor cloud usando um token (ou API key).

Para gerar uma API key, acesse o [ID Magalu](https://id.magalu.com/) e faça o login. Após isso, clique em `Avançado` e, então em `Api Key`. Na nova tela, clique em `Criar Api Key`.

Na tela de criação, preencha o nome, a data de validade e as permissões
necessárias. Para esse workshop, as permissões necessárias são `MKE`, `Network`, `Object Storage`, `Profile` e `Virtual Machine`. Por fim, clique em `Criar`.

### Criando os recursos
Com a chave criada, preencha o arquivo terraform.tfvars do respectivo projeto

__virtual-machine__
```tf
mgc_api_key = "<api key magalu>"
ssh_key     = "<caminho da chave ssh>"
```

Com as credenciais preenchidas execute os seguintes comandos
```sh
terraform init -upgrade
terraform plan
terraform apply
```

Pronto, os recursos já estarão sendo criados na Magalu Cloud!