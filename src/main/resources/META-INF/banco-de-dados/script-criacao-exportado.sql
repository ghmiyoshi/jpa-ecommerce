
    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    alter table pedidos 
       add constraint unq_cliente_id unique (cliente_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');

    create table categorias (
        categoria_pai_id bigint,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table clientes_contatos (
        cliente_id bigint not null,
        numero varchar(255),
        tipo enum ('CELULAR','COMERCIAL','EMAIL','RESIDENCIAL') not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table clientes_detalhes (
        data_nascimento date,
        cliente_id bigint not null,
        sexo enum ('FEMININO','MASCULINO'),
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoques (
        quantidade integer not null,
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        produto_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedidos (
        preco_produto decimal(38,2) not null,
        quantidade integer not null,
        pedido_id bigint not null,
        produto_id bigint not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table notas_fiscais (
        data_criacao datetime(6),
        data_emissao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamentos (
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        pedido_id bigint not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(255),
        nome_titular varchar(255) not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO'),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedidos (
        total decimal(19,2) not null,
        cliente_id bigint not null,
        data_conclusao datetime(6),
        data_criacao datetime(6),
        data_pedido datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nota_fiscal_id bigint,
        status enum ('AGUARDANDO','CANCELADO','PAGO') not null,
        bairro varchar(255),
        cep varchar(255),
        cidade varchar(255),
        complemento varchar(255),
        estado varchar(255),
        logradouro varchar(255),
        numero varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table produtos (
        preco decimal(38,2),
        data_criacao datetime(6),
        data_ultima_atualizacao datetime(6),
        id bigint not null auto_increment,
        nome varchar(100) not null,
        descricao varchar(275) not null default 'descricao',
        foto blob,
        primary key (id)
    ) engine=InnoDB;

    create table produtos_atributos (
        produto_id bigint not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produtos_categorias (
        categoria_id bigint not null,
        produto_id bigint not null
    ) engine=InnoDB;

    create table produtos_tags (
        produto_id bigint not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    create index idx_nome 
       on clientes (nome);

    alter table clientes 
       add constraint unq_cpf unique (cpf);

    alter table estoques 
       add constraint UK_kcsbra62r4qnap50cjmh5l74e unique (produto_id);

    create index idx_nome 
       on produtos (nome);

    alter table produtos 
       add constraint UK_68les18ejq8cjyxw9snrbtd7t unique (nome);

    alter table categorias 
       add constraint fk_categorias_categoria_pai 
       foreign key (categoria_pai_id) 
       references categorias (id);

    alter table clientes_contatos 
       add constraint FK3usuldslpjhu5p21320wd190r 
       foreign key (cliente_id) 
       references clientes (id);

    alter table clientes_detalhes 
       add constraint fk_clientes_detalhes_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table estoques 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table item_pedidos 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table notas_fiscais 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pagamentos 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedidos (id);

    alter table pedidos 
       add constraint fk_pedidos_clientes 
       foreign key (cliente_id) 
       references clientes (id);

    alter table produtos_atributos 
       add constraint FKlv6odu9xc1lajosymi0vfad34 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_categoria 
       foreign key (categoria_id) 
       references categorias (id);

    alter table produtos_categorias 
       add constraint fk_produtos_categorias_produto 
       foreign key (produto_id) 
       references produtos (id);

    alter table produtos_tags 
       add constraint FKjb8hk8t3qsc5v4dmo54gsf6d7 
       foreign key (produto_id) 
       references produtos (id);

    create table testando (
        id integer not null auto_increment,
        primary key (id)
    ) engine=InnoDB;
INSERT INTO produtos (id, nome, preco, data_criacao, descricao) VALUES (1, 'Kindle', 499.0, sysdate(), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
INSERT INTO clientes (id, nome, cpf) VALUES (1, 'Fernando Medeiros', '123.456.789-10');
INSERT INTO clientes (id, nome, cpf) VALUES (2, 'Marcos Mariano', '123.456.789-11');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (1, '1990-01-01');
INSERT INTO clientes_detalhes (cliente_id, data_nascimento) VALUES (2, '1990-01-01');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (1, 1, sysdate(), 998.0, 'AGUARDANDO');
INSERT INTO pedidos (id, cliente_id, data_pedido, total, status) VALUES (2, 2, sysdate(), 499.0, 'AGUARDANDO');
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (1, 1, 499, 2);
INSERT INTO item_pedidos (pedido_id, produto_id, preco_produto, quantidade) VALUES (2, 1, 499, 1);
INSERT INTO categorias (id, nome) VALUES (1, 'Eletrônicos');
INSERT INTO categorias (id, nome) VALUES (2, 'Livros');
INSERT INTO categorias (id, nome) VALUES (3, 'Informática');
INSERT INTO produtos_categorias (produto_id, categoria_id) values (1, 2);
INSERT INTO pagamentos (data_criacao, pedido_id, tipo_pagamento, numero_cartao, codigo_barras, nome_titular, status) VALUES (sysdate(), 1, 'cartao', '123-456', null, 'Gabriel', 'PROCESSANDO');
