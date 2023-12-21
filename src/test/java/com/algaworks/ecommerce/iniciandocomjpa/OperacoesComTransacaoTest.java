package com.algaworks.ecommerce.iniciandocomjpa;

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
}
