package com.algaworks.ecommerce.mapeamentobasico;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Categoria;
import org.junit.jupiter.api.Test;

class EstrategiaChavePrimariaTest extends EntityManagerTest {

  @Test
  void testarEstrategias() {
    final var categoria = new Categoria();
    categoria.setNome("Eletrônicos");

    entityManager.getTransaction().begin();
    entityManager.persist(categoria);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var categoriaVerificacao = entityManager.find(Categoria.class, categoria.getId());

    assertNotNull(categoriaVerificacao);
  }
}
