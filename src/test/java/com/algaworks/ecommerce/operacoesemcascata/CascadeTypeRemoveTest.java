package com.algaworks.ecommerce.operacoesemcascata;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.ItemPedido;
import com.algaworks.ecommerce.models.ItemPedidoId;
import com.algaworks.ecommerce.models.Pedido;
import com.algaworks.ecommerce.models.Produto;
import org.junit.jupiter.api.Test;

class CascadeTypeRemoveTest extends EntityManagerTest {

  // @Test
  void removerItensOrfaos() {
    final var pedido = entityManager.find(Pedido.class, 1);

    assertFalse(pedido.getItens().isEmpty());

    entityManager.getTransaction().begin();
    pedido.getItens().clear();
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
    assertTrue(pedidoVerificacao.getItens().isEmpty());
  }

  @Test
  void removerRelacaoProdutoCategoria() {
    final var produto = entityManager.find(Produto.class, 1);

    assertFalse(produto.getCategorias().isEmpty());

    entityManager.getTransaction().begin();
    produto.getCategorias().clear();
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var produtoVerificacao = entityManager.find(Produto.class, produto.getId());
    assertTrue(produtoVerificacao.getCategorias().isEmpty());
  }

  // @Test
  void removerPedidoEItens() {
    final var pedido = entityManager.find(Pedido.class, 1);

    entityManager.getTransaction().begin();
    entityManager.remove(pedido); // Necessário CascadeType.REMOVE no atributo "itens".
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
    assertNull(pedidoVerificacao);
  }

  // @Test
  void removerItemPedidoEPedido() {
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
