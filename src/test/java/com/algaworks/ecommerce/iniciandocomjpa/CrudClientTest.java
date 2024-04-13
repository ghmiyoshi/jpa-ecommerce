package com.algaworks.ecommerce.iniciandocomjpa;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

@TestMethodOrder(OrderAnnotation.class)
class CrudClientTest extends EntityManagerTest {

  @Test
  void inserirPrimeiroCliente() {
    final var cliente = new Cliente();
    cliente.setNome("Gabriel");
    cliente.setCpf("12345678919");

    entityManager.getTransaction().begin();
    entityManager.persist(cliente);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var clienteInserido = entityManager.find(Cliente.class, cliente.getId());

    assertNotNull(clienteInserido);
    assertEquals(cliente.getNome(), clienteInserido.getNome());
  }

  @Order(1)
  @Test
  void buscarCliente() {
    final var cliente = entityManager.find(Cliente.class, 2L);

    assertNotNull(cliente);
    assertEquals("Marcos Mariano", cliente.getNome());
  }

  @Order(2)
  @Test
  void atualizarCliente() {
    final var cliente = entityManager.find(Cliente.class, 2L);
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
    cliente.getPedidos()
        .forEach(pedido -> pedido.getItens().forEach(entityManager::remove));
    cliente.getPedidos().forEach(pedido -> entityManager.remove(pedido.getPagamento()));
    cliente.getPedidos().forEach(entityManager::remove);
    entityManager.remove(cliente);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var clienteRemovido = entityManager.find(Cliente.class, cliente.getId());

    assertNull(clienteRemovido);
  }
}
