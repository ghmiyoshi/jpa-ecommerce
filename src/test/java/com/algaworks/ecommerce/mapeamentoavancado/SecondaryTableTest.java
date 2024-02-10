package com.algaworks.ecommerce.mapeamentoavancado;

import static com.algaworks.ecommerce.models.SexoEnum.MASCULINO;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;

class SecondaryTableTest extends EntityManagerTest {

  @Test
  void salvarCliente() {
    final var cliente = new Cliente();
    cliente.setNome("Carlos Finotti");
    cliente.setSexo(MASCULINO);
    cliente.setDataNascimento(LocalDate.of(1990, 1, 1));
    cliente.setCpf("12345678901");

    entityManager.getTransaction().begin();
    entityManager.persist(cliente);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());

    assertNotNull(clienteVerificacao.getSexo());
  }
}
