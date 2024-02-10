package com.algaworks.ecommerce.conhecendoentitymanager;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.AGUARDANDO;
import static com.algaworks.ecommerce.models.StatusPedidoEnum.PAGO;
import static java.math.BigDecimal.TEN;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.Pedido;
import org.junit.jupiter.api.Test;

class CallbacksTest extends EntityManagerTest {

  @Test
  void acionarCallbacks() {
    final var cliente = entityManager.find(Cliente.class, 2);

    final var pedido = new Pedido();

    pedido.setCliente(cliente);
    pedido.setStatus(AGUARDANDO);
    pedido.setTotal(TEN);

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
