INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');

INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');

-- INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);

INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');

INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');
