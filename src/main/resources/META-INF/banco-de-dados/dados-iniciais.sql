INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');

INSERT INTO clientes (id, nome) VALUES (1, 'Fernando Medeiros');
INSERT INTO clientes (id, nome) VALUES (2, 'Marcos Mariano');
INSERT INTO clientes_detalhes (id, cliente_id, data_nascimento) VALUES (1, 1, '1990-01-01');
INSERT INTO clientes_detalhes (id, cliente_id, data_nascimento) VALUES (2, 2, '1990-01-01');

INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 100.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 5.0, 2);

INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');