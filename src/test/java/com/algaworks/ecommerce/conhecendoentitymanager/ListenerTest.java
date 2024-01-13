package com.algaworks.ecommerce.conhecendoentitymanager;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.AGUARDANDO;
import static com.algaworks.ecommerce.models.StatusPedidoEnum.PAGO;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.Pedido;
import com.algaworks.ecommerce.models.Produto;
import org.junit.jupiter.api.Test;

class ListenerTest extends EntityManagerTest {

  @Test
  void carregarEntidades() {
    final var pedido = entityManager.find(Pedido.class, 1);
    final var produto = entityManager.find(Produto.class, 1);
  }

  @Test
  void acionarListener() {
    final var cliente = entityManager.find(Cliente.class, 1);

    final var pedido = new Pedido();

    pedido.setCliente(cliente);
    pedido.setStatus(AGUARDANDO);

    entityManager.getTransaction().begin();

    entityManager.persist(pedido);
    entityManager.flush();

    pedido.setStatus(PAGO);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
    assertNotNull(pedidoVerificacao.getDataCriacao());
    assertNotNull(pedidoVerificacao.getDataUltimaAtualizacao());
  }
}
