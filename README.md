# Sistema de Gerenciamento de Restaurante

## Sobre o projeto

Este projeto foi desenvolvido para a disciplina de Banco de Dados e tem como objetivo criar um sistema para organizar as principais operações de um restaurante.

O banco de dados permite cadastrar clientes, funcionários, mesas, pratos e categorias, além de registrar pedidos, seus respectivos itens e pagamentos.

## Integrante

- Vinicius da Silva Pereira Fagundes, GES: 653

## Estrutura do banco

O banco de dados `restaurante_db` possui 8 tabelas:

- Cliente
- Funcionário
- Mesa
- Categoria
- Prato
- Pedido
- Item_Pedido
- Pagamento

O projeto também utiliza relacionamentos 1:1, 1:N e N:M, além de chaves primárias e estrangeiras para manter a organização e a integridade dos dados.

## Recursos implementados

- Criação e estruturação do banco de dados.
- Inserção de dados fictícios para testes.
- Operações de INSERT, UPDATE, DELETE e SELECT.
- Criação de dois usuários e uma ROLE para gerenciamento de permissões.
- Consultas utilizando JOIN.
- Criação de uma Procedure para listar pedidos ativos.
- Criação de uma View para gerar um relatório gerencial.
- Criação de uma Trigger para validar formas de pagamento.

## Como executar

1. Abra o MySQL Workbench.
2. Execute o script SQL do projeto.
3. Selecione o banco de dados `restaurante_db`.
4. Execute os comandos e consultas para testar as funcionalidades.

**Observação:** os comandos de criação de usuários e permissões devem ser executados com uma conta que possua privilégios administrativos.

