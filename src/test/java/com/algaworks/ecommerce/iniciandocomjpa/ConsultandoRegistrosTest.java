package com.algaworks.ecommerce.iniciandocomjpa;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Produto;
import org.junit.jupiter.api.Test;

class ConsultandoRegistrosTest extends EntityManagerTest {

  @Test
  void buscarPorIdentificador() {
    //final var produto = entityManager.find(Produto.class, 1L);
    /* getReference só vai no banco quando fazer um get em um dos atributos */
    final var produto = entityManager.getReference(Produto.class, 1L);

    assertNotNull(produto);
    assertEquals("Kindle", produto.getNome());
  }

  @Test
  void atualizarAReferencia() {
    final var produto = entityManager.find(Produto.class, 1L);
    produto.setNome("Microfone Samson");

    entityManager.refresh(produto);

    assertEquals("Kindle", produto.getNome());
  }
}
