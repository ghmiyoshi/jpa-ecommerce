package com.algaworks.ecommerce.operacoesemcascata;

import static com.algaworks.ecommerce.models.SexoEnum.MASCULINO;
import static com.algaworks.ecommerce.models.StatusPedidoEnum.AGUARDANDO;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Categoria;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.ItemPedido;
import com.algaworks.ecommerce.models.ItemPedidoId;
import com.algaworks.ecommerce.models.Pedido;
import com.algaworks.ecommerce.models.Produto;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import org.junit.jupiter.api.Test;

class CascadeTypePersistTest extends EntityManagerTest {

  @Test
  void persistirPedidoComItens() {
    final var cliente = new Cliente();
    cliente.setDataNascimento(LocalDate.of(1980, 1, 1));
    cliente.setSexo(MASCULINO);
    cliente.setNome("José Carlos");
    cliente.setCpf("01234567890");

    final var produto = entityManager.find(Produto.class, 1);

    final var pedido = new Pedido();
    pedido.setDataCriacao(LocalDateTime.now());
    pedido.setCliente(cliente);
    pedido.setTotal(produto.getPreco());
    pedido.setStatus(AGUARDANDO);

    final var itemPedido = new ItemPedido();
    itemPedido.setId(new ItemPedidoId());
    itemPedido.setPedido(pedido);
    itemPedido.setProduto(produto);
    itemPedido.setQuantidade(1);

    pedido.setItens(Arrays.asList(itemPedido)); // CascadeType.PERSIST

    entityManager.getTransaction().begin();
    entityManager.persist(cliente);
    entityManager.persist(pedido);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
    assertNotNull(pedidoVerificacao);
    assertFalse(pedidoVerificacao.getItens().isEmpty());
  }

  @Test
  void persistirItemPedidoComPedido() {
    final var cliente = entityManager.find(Cliente.class, 2);
    final var produto = entityManager.find(Produto.class, 1);

    final var pedido = new Pedido();
    pedido.setDataCriacao(LocalDateTime.now());
    pedido.setCliente(cliente);
    pedido.setTotal(produto.getPreco());
    pedido.setStatus(AGUARDANDO);

    final var itemPedido = new ItemPedido();
    itemPedido.setId(new ItemPedidoId());
    itemPedido.setPedido(pedido); // Não é necessário CascadeType.PERSIST porque possui @MapsId.
    itemPedido.setProduto(produto);
    itemPedido.setQuantidade(1);

    entityManager.getTransaction().begin();
    entityManager.persist(itemPedido);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
    assertNotNull(pedidoVerificacao);
  }

  @Test
  void persistirPedidoComCliente() {
    final var cliente = new Cliente();
    cliente.setDataNascimento(LocalDate.of(1980, 1, 1));
    cliente.setSexo(MASCULINO);
    cliente.setNome("José Carlos");
    cliente.setCpf("01234567892");

    final var pedido = new Pedido();
    pedido.setDataCriacao(LocalDateTime.now());
    pedido.setCliente(cliente); // CascadeType.PERSIST
    pedido.setTotal(BigDecimal.ZERO);
    pedido.setStatus(AGUARDANDO);

    entityManager.getTransaction().begin();
    entityManager.persist(pedido);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());
    assertNotNull(clienteVerificacao);
  }

  @Test
  void persistirProdutoComCategoria() {
    final var produto = new Produto();
    produto.setDataCriacao(LocalDateTime.now());
    produto.setPreco(BigDecimal.TEN);
    produto.setNome("Fones de Ouvido");
    produto.setDescricao("A melhor qualidade de som");

    final var categoria = new Categoria();
    categoria.setNome("Áudio");

    produto.setCategorias(Arrays.asList(categoria)); // CascadeType.PERSIST

    entityManager.getTransaction().begin();
    entityManager.persist(produto);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var categoriaVerificacao = entityManager.find(Categoria.class, categoria.getId());
    assertNotNull(categoriaVerificacao);
  }
}
