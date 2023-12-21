package com.algaworks.ecommerce.iniciandocomjpa;

import com.algaworks.ecommerce.EntityManagerTest;
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
}
