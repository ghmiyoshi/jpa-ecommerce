package com.algaworks.ecommerce.operacoesemcascata;

import static org.junit.jupiter.api.Assertions.assertNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.ItemPedido;
import com.algaworks.ecommerce.models.ItemPedidoId;
import com.algaworks.ecommerce.models.Pedido;

public class CascadeTypeRemoveTest extends EntityManagerTest {

  // @Test
  public void removerPedidoEItens() {
    final var pedido = entityManager.find(Pedido.class, 1);

    entityManager.getTransaction().begin();
    entityManager.remove(pedido); // Necessário CascadeType.REMOVE no atributo "itens".
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
    assertNull(pedidoVerificacao);
  }

  // @Test
  public void removerItemPedidoEPedido() {
    final var itemPedido = entityManager.find(
        ItemPedido.class, new ItemPedidoId(1L, 1L));

    entityManager.getTransaction().begin();
    entityManager.remove(itemPedido); // Necessário CascadeType.REMOVE no atributo "pedido".
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, itemPedido.getPedido().getId());
    assertNull(pedidoVerificacao);
  }
}
