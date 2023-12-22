package com.algaworks.ecommerce.iniciandocomjpa;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.model.Produto;
import java.math.BigDecimal;
import org.junit.jupiter.api.Test;

class OperacoesComTransacaoTest extends EntityManagerTest {

  @Test
  void abrirEFecharATransacao() {
    // final var produto = new Produto();
    entityManager.getTransaction().begin();

    // código de inserção, atualização ou remoção
    // entityManager.persist(produto);
    // entityManager.merge(produto);
    // entityManager.remove(produto);

    entityManager.getTransaction().commit();
  }

  @Test
  void inserirOPrimeiroObjeto() {
    final var produto = new Produto();
    produto.setId(2L);
    produto.setNome("Câmera Canon");
    produto.setDescricao("A melhor definição para suas fotos");
    produto.setPreco(new BigDecimal(5000));

    entityManager.persist(produto);

    entityManager.getTransaction().begin();
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var produtoVerificacao = entityManager.find(Produto.class, produto.getId());
    assertNotNull(produtoVerificacao);
  }

  @Test
  void removerObjeto() {
    final var produto = entityManager.find(Produto.class, 2L);

    entityManager.getTransaction().begin();
    entityManager.remove(produto);
    entityManager.getTransaction().commit();

    final var produtoVerificacao = entityManager.find(Produto.class, 2L);
    assertNull(produtoVerificacao);
  }

  @Test
  void atualizarObjeto() {
    final var produto = new Produto();
    produto.setId(1L);
    produto.setNome("Kindle Paperwhite");
    produto.setDescricao("Conheça o novo Kindle.");
    produto.setPreco(new BigDecimal(599));

    entityManager.getTransaction().begin();
    entityManager.merge(produto);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var produtoVerificacao = entityManager.find(Produto.class, produto.getId());

    assertNotNull(produtoVerificacao);
    assertEquals("Kindle Paperwhite", produtoVerificacao.getNome());
  }

  @Test
  void atualizarObjetoGerenciado() {
    final var produto = entityManager.find(Produto.class, 1L);

    produto.setNome("Kindle Paperwhite 2ª geração");

    entityManager.getTransaction().begin();
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var produtoVerificacao = entityManager.find(Produto.class, produto.getId());

    assertNotNull(produtoVerificacao);
    assertEquals("Kindle Paperwhite 2ª geração", produtoVerificacao.getNome());
  }

  @Test
  void inserirObjetoComMerge() {
    final var produto = new Produto();
    produto.setId(4L);
    produto.setNome("Microfone Rode Videmic");
    produto.setDescricao("A melhor qualidade de som.");
    produto.setPreco(new BigDecimal(1000));

    entityManager.getTransaction().begin();
    entityManager.merge(produto);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var produtoVerificacao = entityManager.find(Produto.class, produto.getId());

    assertNotNull(produtoVerificacao);
  }

  @Test
  void mostrarDiferencaPersistMerge() {
    final var produtoPersist = new Produto();
    produtoPersist.setId(5L);
    produtoPersist.setNome("Smartphone One Plus");
    produtoPersist.setDescricao("O processador mais rápido.");
    produtoPersist.setPreco(new BigDecimal(2000));

    entityManager.getTransaction().begin();
    entityManager.persist(produtoPersist);
    produtoPersist.setNome("Smartphone Two Plus");
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var produtoVerificacaoPersist = entityManager.find(Produto.class, produtoPersist.getId());
    assertNotNull(produtoVerificacaoPersist);

    var produtoMerge = new Produto();
    produtoMerge.setId(6L);
    produtoMerge.setNome("Notebook Dell");
    produtoMerge.setDescricao("O melhor da categoria.");
    produtoMerge.setPreco(new BigDecimal(2000));

    entityManager.getTransaction().begin();
    produtoMerge = entityManager.merge(produtoMerge);
    produtoMerge.setNome("Notebook Dell 2");
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var produtoVerificacaoMerge = entityManager.find(Produto.class, produtoMerge.getId());
    assertNotNull(produtoVerificacaoMerge);
  }

  @Test
  void impedirOperacaoComBancoDeDados() {
    final var produto = entityManager.find(Produto.class, 1L);
    entityManager.detach(produto);

    entityManager.getTransaction().begin();
    produto.setNome("Kindle Paperwhite 2ª geração");
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var produtoVerificacao = entityManager.find(Produto.class, produto.getId());

    assertNotNull(produtoVerificacao);
    assertEquals("Kindle", produtoVerificacao.getNome());
  }
}
