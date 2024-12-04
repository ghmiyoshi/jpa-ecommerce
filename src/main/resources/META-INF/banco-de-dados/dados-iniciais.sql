INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (2, 'Alexa', 300.0, sysdate(), 'Alexa inteligente');

INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');

INSERT INTO pedidos (id, cliente_id, data_pedido, data_criacao, total, status) VALUES (1, 1,'2024-06-09 23:32:23', sysdate(),998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, data_criacao, total, status) VALUES (2, 2,'2024-06-09 23:32:23', sysdate(), 499.0,'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 2, 300, 1);

INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');

INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

INSERT INTO notas_fiscais (pedido_id, data_emissao, xml) VALUES (1, sysdate(), '<?xml version="1.0" encoding="UTF-8"?><xml></xml>');