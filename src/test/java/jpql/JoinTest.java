package jpql;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Pedido;
import java.util.List;
import org.junit.jupiter.api.Test;

class JoinTest extends EntityManagerTest {

    @Test
    void fazerJoin() {
        final var jpql = "select p from Pedido p join p.pagamento pag";

        List<Pedido> pedidos = entityManager.createQuery(jpql, Pedido.class).getResultList();

        assertFalse(pedidos.isEmpty());
        assertEquals(1, pedidos.size());
    }

    @Test
    void fazerJoin2() {
        final var jpql = "select p, pag from Pedido p join p.pagamento pag";

        List<Object[]> results = entityManager.createQuery(jpql, Object[].class).getResultList();

        assertFalse(results.isEmpty());
        assertEquals(1, results.size());
    }

    @Test
    void fazerJoin3() {
        final var jpql = "select p from Pedido p join p.itens i";

        List<Object[]> results = entityManager.createQuery(jpql, Object[].class).getResultList();

        assertFalse(results.isEmpty());
        assertEquals(2, results.size());
    }

    @Test
    void fazerJoinComJoin() {
        final var jpql = "select prod from Pedido p join p.itens i join i.produto prod";

        List<Object[]> results = entityManager.createQuery(jpql, Object[].class).getResultList();

        assertFalse(results.isEmpty());
        assertEquals(2, results.size());
    }

    @Test
    void userJoinFetch() {
        final var jpql = "select p from Pedido p left join fetch p.pagamento pag left join fetch " +
                "p.cliente left join fetch p.notaFiscal";
        final var pedidos = entityManager.createQuery(jpql, Pedido.class).getResultList();

        assertFalse(pedidos.isEmpty());
        assertEquals(2, pedidos.size());
    }
}
