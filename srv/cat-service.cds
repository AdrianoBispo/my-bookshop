// Importa as definições do nosso modelo de dados para que possamos usá-las aqui.
using my.bookshop as my from '../db/schema';

// Define o serviço CatalogService, que expõe nossas entidades como APIs.
service CatalogService {
  /**
   * Expõe a entidade Livros como um serviço somente leitura.
   * A anotação `@readonly` garante que os usuários só possam ler os dados.
   * `as projection on my.Livros` cria uma "visão" da nossa entidade do banco de dados.
   */
  entity Livros @readonly as projection on my.Livros;

  /**
   * Expõe a entidade Autores como um serviço somente leitura.
   */
  entity Autores @readonly as projection on my.Autores;

  /**
   * Expõe a entidade Pedidos como um serviço somente para inserção.
   * A anotação `@insertonly` permite que os usuários apenas criem novos pedidos.
   */
  entity Pedidos @insertonly as projection on my.Pedidos;
}
