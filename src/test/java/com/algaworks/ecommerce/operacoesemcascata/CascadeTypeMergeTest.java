package com.algaworks.ecommerce.operacoesemcascata;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.AGUARDANDO;
import static com.algaworks.ecommerce.models.StatusPedidoEnum.PAGO;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Categoria;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.ItemPedido;
import com.algaworks.ecommerce.models.ItemPedidoId;
import com.algaworks.ecommerce.models.Pedido;
import com.algaworks.ecommerce.models.Produto;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Arrays;
import org.junit.jupiter.api.Test;

class CascadeTypeMergeTest extends EntityManagerTest {

  @Test
  void atualizarProdutoComCategoria() {
    final var produto = new Produto();
    produto.setId(1L);
    produto.setDataUltimaAtualizacao(LocalDateTime.now());
    produto.setPreco(new BigDecimal(500));
    produto.setNome("Kindle");
    produto.setDescricao("Agora com iluminação embutida ajustável.");

    final var categoria = new Categoria();
    categoria.setId(2L);
    categoria.setNome("Tablets");

    produto.setCategorias(Arrays.asList(categoria)); // CascadeType.MERGE

    entityManager.getTransaction().begin();
    entityManager.merge(produto);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var categoriaVerificacao = entityManager.find(Categoria.class, categoria.getId());
    assertEquals("Tablets", categoriaVerificacao.getNome());
  }

  @Test
  void atualizarPedidoComItens() {
    final var cliente = entityManager.find(Cliente.class, 1);
    final var produto = entityManager.find(Produto.class, 1);

    final var pedido = new Pedido();
    pedido.setId(2L);
    pedido.setCliente(cliente);
    pedido.setStatus(AGUARDANDO);

    final var itemPedido = new ItemPedido();
    itemPedido.setId(new ItemPedidoId());
    itemPedido.getId().setPedidoId(pedido.getId());
    itemPedido.getId().setProdutoId(produto.getId());
    itemPedido.setPedido(pedido);
    itemPedido.setProduto(produto);
    itemPedido.setQuantidade(3);
    itemPedido.setPrecoProduto(produto.getPreco());

    pedido.setItens(Arrays.asList(itemPedido)); // CascadeType.MERGE

    entityManager.getTransaction().begin();
    entityManager.merge(pedido);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var itemPedidoVerificacao = entityManager.find(ItemPedido.class, itemPedido.getId());
    assertEquals(3, itemPedidoVerificacao.getQuantidade());
  }

  @Test
  void atualizarItemPedidoComPedido() {
    final var cliente = entityManager.find(Cliente.class, 1);
    final var produto = entityManager.find(Produto.class, 1);

    final var pedido = new Pedido();
    pedido.setId(2L);
    pedido.setCliente(cliente);
    pedido.setStatus(PAGO);

    final var itemPedido = new ItemPedido();
    itemPedido.setId(new ItemPedidoId());
    itemPedido.getId().setPedidoId(pedido.getId());
    itemPedido.getId().setProdutoId(produto.getId());
    itemPedido.setPedido(pedido); // CascadeType.MERGE
    itemPedido.setProduto(produto);
    itemPedido.setQuantidade(5);
    itemPedido.setPrecoProduto(produto.getPreco());

    pedido.setItens(Arrays.asList(itemPedido));

    entityManager.getTransaction().begin();
    entityManager.merge(itemPedido);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var itemPedidoVerificacao = entityManager.find(ItemPedido.class, itemPedido.getId());
    assertTrue(PAGO.equals(itemPedidoVerificacao.getPedido().getStatus()));
  }
}
