package com.algaworks.ecommerce.mapeamentoavancado;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.AGUARDANDO;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.ItemPedido;
import com.algaworks.ecommerce.models.ItemPedidoId;
import com.algaworks.ecommerce.models.Pedido;
import com.algaworks.ecommerce.models.Produto;
import java.time.LocalDateTime;
import org.junit.jupiter.api.Test;

class ChaveCompostaTest extends EntityManagerTest {

  @Test
  void salvarItem() {
    entityManager.getTransaction().begin();

    final var cliente = entityManager.find(Cliente.class, 2);
    final var produto = entityManager.find(Produto.class, 1);

    final var pedido = new Pedido();
    pedido.setCliente(cliente);
    pedido.setDataCriacao(LocalDateTime.now());
    pedido.setStatus(AGUARDANDO);
    pedido.setTotal(produto.getPreco());

    entityManager.persist(pedido);

    entityManager.flush();

    final var itemPedido = new ItemPedido();
//    itemPedido.setPedidoId(pedido.getId()); IdClass
//    itemPedido.setProdutoId(produto.getId()); IdClass
    itemPedido.setPedido(pedido);
    itemPedido.setProduto(produto);
    itemPedido.setPrecoProduto(produto.getPreco());
    itemPedido.setQuantidade(1);

    entityManager.persist(itemPedido);

    entityManager.getTransaction().commit();

    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());

    assertNotNull(pedidoVerificacao);
    assertFalse(pedidoVerificacao.getItens().isEmpty());
  }

  @Test
  void bucarItem() {
    final var itemPedido = entityManager.find(
        ItemPedido.class, new ItemPedidoId(2L, 1L));

    assertNotNull(itemPedido);
  }
}
