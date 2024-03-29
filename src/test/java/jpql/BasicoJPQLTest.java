package jpql;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.Pedido;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

class BasicoJPQLTest extends EntityManagerTest {

  @Test
  void buscarPorIdentificador() {
    // entityManager.find(Pedido.class, 1)

    TypedQuery<Pedido> typedQuery = entityManager.createQuery(
        "select p from Pedido p where p.id = 2", Pedido.class);

    final var pedido = typedQuery.getSingleResult();
    assertNotNull(pedido);

    // List<Pedido> lista = typedQuery.getResultList();
    // assertFalse(lista.isEmpty());
  }

  @Test
  void mostrarDiferencaQueries() {
    String jpql = "select p from Pedido p where p.id = 2";

    TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
    final var pedido1 = typedQuery.getSingleResult();
    assertNotNull(pedido1);

    Query query = entityManager.createQuery(jpql);
    Pedido pedido2 = (Pedido) query.getSingleResult();
    assertNotNull(pedido2);

    // List<Pedido> lista = query.getResultList();
    // assertFalse(lista.isEmpty());
  }

  @Test
  void selecionarUmAtributoParaRetorno() {
    final var jpql = "select p.nome from Produto p";

    TypedQuery<String> typedQuery = entityManager.createQuery(jpql, String.class);
    final var lista = typedQuery.getResultList();
    assertEquals(String.class, lista.get(0).getClass());

    final var jpqlCliente = "select p.cliente from Pedido p";
    TypedQuery<Cliente> typedQueryCliente = entityManager.createQuery(jpqlCliente, Cliente.class);
    final var listaClientes = typedQueryCliente.getResultList();
    assertEquals(Cliente.class, listaClientes.get(0).getClass());
  }
}