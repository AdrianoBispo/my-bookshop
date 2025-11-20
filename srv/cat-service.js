// Este é o arquivo de implementação do nosso serviço.
// Aqui, podemos adicionar lógica de negócios customizada aos eventos do serviço.
module.exports = (srv) => {

  // Obtém a definição da entidade 'Livros' do nosso modelo de dados.
  // Isso nos permite interagir com a tabela de livros no banco de dados.
  const { Livros } = cds.entities('my.bookshop');

  /**
   * Lógica customizada ANTES da criação de um novo Pedido.
   * Este handler é acionado sempre que uma requisição 'CREATE' para a entidade 'Pedidos' é recebida.
   * O objetivo é reduzir o estoque do livro que está sendo pedido.
   */
  srv.before('CREATE', 'Pedidos', async (req) => {
    const pedido = req.data; // Os dados do pedido vindo na requisição

    // Validação: Garante que a quantidade do pedido seja um número positivo.
    if (!pedido.quantidade || pedido.quantidade <= 0) {
      return req.error(400, 'Peça pelo menos 1 livro');
    }

    // Inicia uma transação no banco de dados para garantir a consistência dos dados.
    const tx = cds.transaction(req);
    
    // Executa um comando de atualização (UPDATE) na entidade 'Livros'.
    const affectedRows = await tx.run(
      UPDATE(Livros)
        // Define que o campo 'estoque' deve ser decrementado pela 'quantidade' do pedido.
        .set({ estoque: { '-=': pedido.quantidade } })
        // A cláusula 'where' especifica qual livro deve ser atualizado.
        .where({ estoque: { '>=': pedido.quantidade }, /*and*/ ID: pedido.livro_ID })
    );

    // Se nenhuma linha foi afetada, significa que o livro não tinha estoque suficiente.
    // Nesse caso, a transação é revertida e um erro é retornado ao cliente.
    if (affectedRows === 0) {
      req.error(409, 'Esgotado, desculpe');
    }
  });

  /**
   * Lógica customizada DEPOIS da leitura da entidade 'Livros'.
   * Este handler é acionado sempre que uma requisição 'READ' para 'Livros' é concluída.
   * O objetivo é adicionar um texto de desconto ao título de livros com muito estoque.
   */
  srv.after('READ', 'Livros', each => {
    // Para cada livro lido, verifica se o estoque é maior que 111.
    if (each.estoque > 111) {
      // Se for, adiciona um sufixo de desconto ao título do livro.
      // Isso é uma modificação temporária nos dados retornados, não altera o banco de dados.
      each.titulo += ' -- 11% de desconto!';
    }
  });

}
