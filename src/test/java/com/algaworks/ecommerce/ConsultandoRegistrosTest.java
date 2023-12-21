package com.algaworks.ecommerce;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.model.Produto;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

public class ConsultandoRegistrosTest {

  private static EntityManagerFactory entityManagerFactory;
  private static EntityManager entityManager;

  @BeforeAll
  static void setUpBeforeClass() {
    entityManagerFactory = Persistence.createEntityManagerFactory("Ecommerce-PU");
    entityManager = entityManagerFactory.createEntityManager();
  }

  @AfterAll
  static void tearDownAfterClass() {
    entityManager.close();
    entityManagerFactory.close();
  }

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
