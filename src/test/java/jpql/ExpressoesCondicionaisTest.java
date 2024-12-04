package jpql;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Pedido;
import com.algaworks.ecommerce.models.Produto;
import jakarta.persistence.TypedQuery;
import java.time.LocalDateTime;
import java.util.List;
import org.junit.jupiter.api.Test;

class ExpressoesCondicionaisTest extends EntityManagerTest {

    @Test
    void usarExpressaoCondicionalLike() {
        String jpql = "select c from Cliente c where c.nome like concat('%', :nome, '%')";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        typedQuery.setParameter("nome", "a");

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    void usarIsNull() {
        final var jpql = "select p from Produto p where p.descricao is null";

        final var lista = entityManager.createQuery(jpql, Object[].class).getResultList();

        assertTrue(lista.isEmpty());
    }

    @Test
    void usarIsEmpty() {
        final var jpql = "select p from Produto p where p.categorias is empty";

        final var lista = entityManager.createQuery(jpql, Object[].class).getResultList();

        assertTrue(lista.isEmpty());
    }

    @Test
    void usarBetween() {
        final var jpql = "select p from Pedido p where p.dataCriacao between :dataInicial and " +
                ":dataFinal";

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        typedQuery.setParameter("dataInicial", LocalDateTime.now().minusDays(10));
        typedQuery.setParameter("dataFinal", LocalDateTime.now().plusDays(1));

        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    void usarExpressaoDiferente() {
        final var jpql = "select p from Produto p where p.preco <> 100";

        List<Produto> lista = entityManager.createQuery(jpql, Produto.class).getResultList();

        assertFalse(lista.isEmpty());
    }
}
