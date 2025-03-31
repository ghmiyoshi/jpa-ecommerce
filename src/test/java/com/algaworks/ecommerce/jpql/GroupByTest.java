package com.algaworks.ecommerce.jpql;

import com.algaworks.ecommerce.EntityManagerTest;
import org.junit.jupiter.api.Test;

class GroupByTest extends EntityManagerTest {

    @Test
    void testGroupBy() {
        // Quantidade de produtos por categoria
        final var jpql = "SELECT c.nome, count(p.id) FROM Categoria c JOIN "
                + "c.produtos p GROUP BY c.id";

        // Total de vendas por mes
        final var jpql2 = "SELECT DATE_FORMAT(p.dataCriacao, '%Y/%m') AS periodo, SUM(p.total)"
                + " FROM Pedido p GROUP BY DATE_FORMAT(p.dataCriacao, '%Y/%m')";

        // Total de vendas por categoria
        final var jpql3 = "SELECT c.nome, SUM(p.preco) FROM ItemPedido ip JOIN "
                + "ip.produto p JOIN p.categorias c GROUP BY c.id";

        // Total de vendas por cliente
        final var jpql4 = "select c.nome, sum(p.total) as total from clientes c"
        + "inner join pedidos p on c.id = p.cliente_id group by c.id";

        //  Total de vendas por dia e por categoria
        /* select date(pedido.data_criacao),
                concat(categoria.nome, ': ', sum(produto.preco * ip.quantidade)) as total
        from item_pedidos ip
        inner join pedidos pedido on ip.pedido_id = pedido.id
        inner join produtos produto on ip.produto_id = produto.id
        inner join produtos_categorias pc on produto.id = pc.produto_id
        inner join categorias categoria on pc.categoria_id = categoria.id
        group by date(pedido.data_criacao), categoria.id
        order by date(pedido.data_criacao), categoria.nome; */
        
        entityManager.createQuery(jpql3, Object[].class)
                .getResultList()
                .forEach(arr -> System.out.println(arr[0] + ", " + arr[1]));
    }
}
