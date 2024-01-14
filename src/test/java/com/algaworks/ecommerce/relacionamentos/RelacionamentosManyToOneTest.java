package com.algaworks.ecommerce.relacionamentos;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.AGUARDANDO;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.Pedido;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import org.junit.jupiter.api.Test;

class RelacionamentosManyToOneTest extends EntityManagerTest {

  @Test
  void verificarRelacionamento() {
    final var cliente = entityManager.find(Cliente.class, 1);
    final var pedido = new Pedido();
    pedido.setDataPedido(LocalDateTime.now());
    pedido.setCliente(cliente);
    pedido.setStatus(AGUARDANDO);
    pedido.setTotal(BigDecimal.TEN);

    entityManager.getTransaction().begin();
    entityManager.persist(pedido);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
    final var clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());

    assertNotNull(pedidoVerificacao.getCliente());
    assertFalse(clienteVerificacao.getPedidos().isEmpty());
  }

//  @Test
//  void verificarRelacionamentoItemPedido() {
//    final var cliente = entityManager.find(Cliente.class, 1);
//    final var produto = entityManager.find(Produto.class, 1);
//
//    final var pedido = new Pedido();
//    pedido.setStatus(AGUARDANDO);
//    pedido.setDataPedido(LocalDateTime.now());
//    pedido.setTotal(BigDecimal.TEN);
//    pedido.setCliente(cliente);
//
//    final var itemPedido = new ItemPedido();
//    itemPedido.setPrecoProduto(produto.getPreco());
//    itemPedido.setQuantidade(1);
//    itemPedido.setPedido(pedido);
//    itemPedido.setProduto(produto);
//
//    entityManager.getTransaction().begin();
//    entityManager.persist(pedido);
//    entityManager.persist(itemPedido);
//    entityManager.getTransaction().commit();
//
//    entityManager.clear();
//
//    final var itemPedidoVerificacao = entityManager.find(ItemPedido.class, itemPedido.getId());
//
//    assertNotNull(itemPedidoVerificacao.getPedido());
//    assertNotNull(itemPedidoVerificacao.getProduto());
//  }
}
