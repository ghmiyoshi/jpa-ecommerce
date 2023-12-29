package com.algaworks.ecommerce.relacionamentos;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Pedido;
import org.junit.jupiter.api.Test;

class OptionalTest extends EntityManagerTest {

  @Test
  void verificarComportamento() {
    final var pedido = entityManager.find(Pedido.class, 1L);
  }
}
