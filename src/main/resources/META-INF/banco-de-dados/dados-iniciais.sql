INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');

INSERT INTO clientes (id, nome) VALUES (1, 'Fernando Medeiros');
INSERT INTO clientes (id, nome) VALUES (2, 'Marcos Mariano');
INSERT INTO clientes_detalhes (id, cliente_id, data_nascimento) VALUES (1, 1, '1990-01-01');
INSERT INTO clientes_detalhes (id, cliente_id, data_nascimento) VALUES (2, 2, '1990-01-01');

INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 1, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);

INSERT INTO pagamentos(pedido_id, status, data_pagamento, numero_cartao, titular_cartao) VALUES (1, 'PROCESSANDO', sysdate(), '1234-1234-1234-1234', 'Fernando Medeiros');

INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');