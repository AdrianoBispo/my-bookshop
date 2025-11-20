# My Bookshop

Este é um projeto de exemplo de um serviço de livraria desenvolvido com o [SAP Cloud Application Programming Model (CAP)](https://cap.cloud.sap/docs/get-started/) para Node.js.

## Descrição

O projeto expõe um serviço de catálogo (`CatalogService`) que permite consultar livros e autores, além de criar novos pedidos. Ele utiliza um banco de dados SQLite para desenvolvimento local.

Este projeto foi desenvolvido com base no tutorial da SAP: [Build a Business Application Using CAP for Node.js](https://developers.sap.com/mission.cp-starter-extensions-cap.html).

## Pré-requisitos

Antes de começar, você precisará ter as seguintes ferramentas instaladas:

- [Node.js](https://nodejs.org/en/)
- [SQLite](https://www.sqlite.org/index.html)

## Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/adriano-bispo/my-bookshop.git
   cd my-bookshop
   ```

2. Instale as dependências do projeto:
   ```bash
   npm install
   ```

## Executando o Projeto

Para iniciar o serviço em modo de desenvolvimento (com recarregamento automático), execute:

```bash
cds watch
```

O serviço estará disponível em `http://localhost:4004`.

## Estrutura do Projeto

O projeto segue a estrutura recomendada pelo CAP:

- **`app/`**: Contém as aplicações de UI (frontend).
- **`db/`**: Contém os modelos de dados (`.cds`) e dados iniciais (`.csv`).
- **`srv/`**: Contém os modelos de serviço (`.cds`) e a lógica de implementação (`.js`).
- **`package.json`**: Metadados do projeto e dependências.

## Serviços Disponíveis

### CatalogService

O `CatalogService` expõe as seguintes entidades:

- **`Books`**: Entidade para visualização dos livros.
  - **Endpoint:** `GET /catalog/Books`
- **`Authors`**: Entidade para visualização dos autores.
  - **Endpoint:** `GET /catalog/Authors`
- **`Orders`**: Entidade para inserção de novos pedidos.
  - **Endpoint:** `POST /catalog/Orders`