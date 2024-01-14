package com.algaworks.ecommerce.mapeamentoavancado;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import org.junit.jupiter.api.Test;

class PropriedadesTransientesTest extends EntityManagerTest {

  @Test
  void validarPrimeiroNome() {
    final var cliente = entityManager.find(Cliente.class, 1L);

    assertNotNull(cliente.getNome());
    assertEquals("Fernando", cliente.getPrimeiroNome());
  }
}
