// Define o namespace para o nosso modelo de dados.
// Ajuda a organizar e evitar conflitos de nomes.
namespace my.bookshop;

// Importa tipos comuns da biblioteca do SAP CAP.
// Country: para usar o tipo de dado de país.
// managed: para adicionar campos de gerenciamento automaticamente (ex: createdAt, createdBy).
using { Country, managed } from '@sap/cds/common';

/**
 * Entidade Livros
 * Representa os livros na nossa livraria.
 */
entity Livros {
  key ID : Integer; // Chave primária do livro
  titulo  : localized String; // Título do livro, com suporte a múltiplos idiomas
  autor : Association to Autores; // Associação com a entidade Autores
  estoque  : Integer; // Quantidade de livros em estoque
}

/**
 * Entidade Autores
 * Representa os autores dos livros.
 */
entity Autores {
  key ID : Integer; // Chave primária do autor
  nome   : String; // Nome do autor
  // Associação para muitos livros. Indica que um autor pode ter vários livros.
  // A condição `on livros.autor = $self` especifica como a associação é resolvida.
  livros  : Association to many Livros on livros.autor = $self;
}

/**
 * Entidade Pedidos
 * Representa os pedidos de livros feitos pelos clientes.
 * A anotação `managed` adiciona campos de controle como data de criação e usuário.
 */
entity Pedidos : managed {
  key ID  : UUID; // Chave primária do pedido, um identificador único universal
  livro    : Association to Livros; // Associação com o livro que foi pedido
  pais : Country; // País de onde o pedido foi feito, usando o tipo importado
  quantidade  : Integer; // Quantidade de livros no pedido
}
