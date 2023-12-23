package com.algaworks.ecommerce.mapeamentobasico;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.SexoEnum;
import org.junit.jupiter.api.Test;

class MapeandoEnumeracoesTest extends EntityManagerTest {

  @Test
  void testarEnum() {
    final var cliente = entityManager.find(Cliente.class, 1);
    cliente.setSexo(SexoEnum.MASCULINO);

    entityManager.getTransaction().begin();
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());

    assertNotNull(clienteVerificacao.getSexo());
  }
}
