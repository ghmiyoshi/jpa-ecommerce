package com.algaworks.ecommerce.conhecendoentitymanager;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.AGUARDANDO;
import static com.algaworks.ecommerce.models.StatusPedidoEnum.PAGO;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.Pedido;
import org.junit.jupiter.api.Test;

class CallbacksTest extends EntityManagerTest {

  @Test
  void acionarCallbacks() {
    Cliente cliente = entityManager.find(Cliente.class, 1);

    Pedido pedido = new Pedido();

    pedido.setCliente(cliente);
    pedido.setStatus(AGUARDANDO);

    entityManager.getTransaction().begin();

    entityManager.persist(pedido);
    entityManager.flush();

    pedido.setStatus(PAGO);
    entityManager.getTransaction().commit();

    entityManager.clear();

    Pedido pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
    assertNotNull(pedidoVerificacao.getDataCriacao());
    assertNotNull(pedidoVerificacao.getDataUltimaAtualizacao());
  }
}
