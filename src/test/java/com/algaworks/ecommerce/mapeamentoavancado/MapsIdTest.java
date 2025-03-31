package com.algaworks.ecommerce.mapeamentoavancado;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.AGUARDANDO;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.ItemPedido;
import com.algaworks.ecommerce.models.ItemPedidoId;
import com.algaworks.ecommerce.models.NotaFiscal;
import com.algaworks.ecommerce.models.Pedido;
import com.algaworks.ecommerce.models.Produto;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import org.junit.jupiter.api.Test;

class MapsIdTest extends EntityManagerTest {

  @Test
  void inserirNotaFiscal() {
    final var pedido = entityManager.find(Pedido.class, 2L);

    final var notaFiscal = new NotaFiscal();
    notaFiscal.setXml("<xml/>".getBytes(StandardCharsets.UTF_8));
    notaFiscal.setPedido(pedido);
    notaFiscal.setDataEmissao(LocalDateTime.now());

    entityManager.persist(notaFiscal);

    entityManager.getTransaction().begin();
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var notaFiscalVerificacao = entityManager.find(NotaFiscal.class, pedido.getId());

    assertNotNull(notaFiscalVerificacao);
    assertEquals(pedido.getId(), notaFiscalVerificacao.getId());
  }

  @Test
  void inserirItemPedido() {
    final var cliente = entityManager.find(Cliente.class, 2);
    final var produto = entityManager.find(Produto.class, 1);

    final var pedido = new Pedido();
    pedido.setCliente(cliente);
    pedido.setDataCriacao(LocalDateTime.now());
    pedido.setStatus(AGUARDANDO);
    pedido.setTotal(produto.getPreco());

    final var itemPedido = new ItemPedido();
    itemPedido.setId(new ItemPedidoId());
    itemPedido.setPedido(pedido);
    itemPedido.setProduto(produto);
    itemPedido.setQuantidade(1);

    entityManager.getTransaction().begin();
    entityManager.persist(pedido);
    entityManager.persist(itemPedido);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var itemPedidoVerificacao = entityManager.find(
        ItemPedido.class, new ItemPedidoId(pedido.getId(), produto.getId()));

    assertNotNull(itemPedidoVerificacao);
  }
}
