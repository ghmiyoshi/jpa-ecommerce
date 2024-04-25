package jpql;

import static org.junit.jupiter.api.Assertions.assertFalse;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Pedido;
import org.junit.jupiter.api.Test;

class PathExpressionTest extends EntityManagerTest {

    @Test
    void pathExpression() {
        final var jpql = "select p.cliente.nome from Pedido p";
        final var pedidos = entityManager.createQuery(jpql, Pedido.class).getResultList();

        assertFalse(pedidos.isEmpty());
    }
}
