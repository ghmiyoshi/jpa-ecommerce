INSERT INTO produtos (id, nome, preco, descricao) VALUES (1, 'Kindle', 499.0, 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');

INSERT INTO clientes (id, nome, sexo) VALUES (1, 'Fernando Medeiros', 'MASCULINO');
INSERT INTO clientes (id, nome, sexo) VALUES (2, 'Marcos Mariano', 'MASCULINO');

INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 100.0, 'AGUARDANDO');
INSERT INTO item_pedidos (id, pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 1, 5.0, 2);
