package com.algaworks.ecommerce.jpql;

import static org.junit.jupiter.api.Assertions.assertFalse;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Pedido;
import org.junit.jupiter.api.Test;

class OperadoresLogicosTest extends EntityManagerTest {

    @Test
    void usarOperadores() {
        final var jpql = "select p from Pedido p " +
                " where (p.status = 'AGUARDANDO' or p.status = 'PAGO') and p.total > 100";

        final var pedidos = entityManager.createQuery(jpql, Pedido.class).getResultList();
        assertFalse(pedidos.isEmpty());
    }
}
