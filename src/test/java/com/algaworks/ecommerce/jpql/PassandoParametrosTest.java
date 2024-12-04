package com.algaworks.ecommerce.jpql;

import static com.algaworks.ecommerce.models.StatusPagamentoEnum.PROCESSANDO;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.NotaFiscal;
import com.algaworks.ecommerce.models.Pedido;
import java.time.LocalDateTime;
import org.junit.jupiter.api.Test;

class PassandoParametrosTest extends EntityManagerTest {

    @Test
    void passandoParametro() {
        final var jpql = "select p from Pedido p where p.id = :id";
        // final var jpql = "select p from Pedido p where p.id = ?1";
        final var pedido = entityManager.createQuery(jpql, Pedido.class)
                .setParameter("id", 1)
                // .setParameter(1, 1)
                .getSingleResult();

        assertNotNull(pedido);
        assertEquals(1, pedido.getId());
    }

    @Test
    void passandoParametros() {
        final var jpql = "select p from Pedido p JOIN p.pagamento pag "
                + "where p.id = :id and pag.status = :status";
        final var pedido = entityManager.createQuery(jpql, Pedido.class)
                .setParameter("id", 1)
                .setParameter("status", PROCESSANDO)
                .getSingleResult();

        assertNotNull(pedido);
        assertEquals(1, pedido.getId());
    }

    @Test
    void passandoParametroData() {
        final var jpql = "select nf from NotaFiscal nf where nf.dataEmissao <= :hoje";
        final var notaFiscal = entityManager.createQuery(jpql, NotaFiscal.class)
                .setParameter("hoje", LocalDateTime.now().plusDays(1L))
                .getSingleResult();

        assertNotNull(notaFiscal);
    }
}
