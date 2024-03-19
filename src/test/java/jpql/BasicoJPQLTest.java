package jpql;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Pedido;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

class BasicoJPQLTest extends EntityManagerTest {

  @Test
  void buscarPorIdentificador() {
    // entityManager.find(Pedido.class, 1)

    TypedQuery<Pedido> typedQuery = entityManager
        .createQuery("select p from Pedido p where p.id = 1", Pedido.class);

    final var pedido = typedQuery.getSingleResult();
    assertNotNull(pedido);

    // List<Pedido> lista = typedQuery.getResultList();
    // assertFalse(lista.isEmpty());
  }
}