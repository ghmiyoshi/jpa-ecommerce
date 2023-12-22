package com.algaworks.ecommerce.iniciandocomjpa;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.Cliente;
import org.junit.jupiter.api.Test;

class CrudClientTest extends EntityManagerTest {

  @Test
  void inserirPrimeiroCliente() {
    final var cliente = new Cliente();
    cliente.setNome("Gabriel");

    entityManager.getTransaction().begin();
    entityManager.persist(cliente);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var clienteInserido = entityManager.find(Cliente.class, cliente.getId());

    assertNotNull(clienteInserido);
    assertEquals(cliente.getNome(), clienteInserido.getNome());
  }

  @Test
  void buscarCliente() {
    final var cliente = entityManager.find(Cliente.class, 2L);

    assertNotNull(cliente);
    assertEquals("Marcos Mariano", cliente.getNome());
  }

  @Test
  void atualizarCliente() {
    final var cliente = entityManager.find(Cliente.class, 1L);
    cliente.setNome("Gabriel Hideki");

    entityManager.getTransaction().begin();
    entityManager.merge(cliente);
    entityManager.getTransaction().commit();

    final var clienteAtualizado = entityManager.find(Cliente.class, cliente.getId());

    assertNotNull(clienteAtualizado);
    assertEquals(cliente.getNome(), clienteAtualizado.getNome());
  }

  @Test
  void removerCliente() {
    final var cliente = entityManager.find(Cliente.class, 1L);

    entityManager.getTransaction().begin();
    entityManager.remove(cliente);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var clienteRemovido = entityManager.find(Cliente.class, cliente.getId());

    assertNull(clienteRemovido);
  }
}
