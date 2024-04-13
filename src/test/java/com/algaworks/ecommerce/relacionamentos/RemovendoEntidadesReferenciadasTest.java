package com.algaworks.ecommerce.relacionamentos;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Pedido;
import org.junit.jupiter.api.Test;

class RemovendoEntidadesReferenciadasTest extends EntityManagerTest {

  @Test
  void removerEntidadeRelacionada() {
    final var pedido = entityManager.find(Pedido.class, 2L);
    assertFalse(pedido.getItens().isEmpty());

    entityManager.getTransaction().begin();
    pedido.getItens().forEach(entityManager::remove);
    entityManager.remove(pedido);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, 2);
    assertNull(pedidoVerificacao);
  }
}
