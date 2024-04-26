package jpql;

import static org.junit.jupiter.api.Assertions.assertFalse;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Pedido;
import org.junit.jupiter.api.Test;

class PathExpressionTest extends EntityManagerTest {

    @Test
    void usarPathExpressions() {
        final var jpql = "select p.cliente.nome from Pedido p";
        final var pedidos = entityManager.createQuery(jpql, Pedido.class).getResultList();

        assertFalse(pedidos.isEmpty());
    }

    @Test
    void buscarPedidosComProdutoEspecifico() {
        final var jpql = "select p from Pedido p join p.itens i where i.id.produtoId = 1";
        // String jpql = "select p from Pedido p join p.itens i where i.produto.id = 1";
       // String jpql = "select p from Pedido p join p.itens i join i.produto pro where pro.id = 1";
        final var pedidos = entityManager.createQuery(jpql, Pedido.class).getResultList();

        assertFalse(pedidos.isEmpty());
    }
}
