package com.algaworks.ecommerce.conhecendoentitymanager;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Categoria;
import org.junit.jupiter.api.Test;

class EstadosECicloDeVidaTest extends EntityManagerTest {

  @Test
  void analisarEstados() {
    final var categoriaNovo = new Categoria();
    categoriaNovo.setNome("Eletrônicos");

    final var categoriaGerenciadaMerge = entityManager.merge(categoriaNovo);

    final var categoriaGerenciada = entityManager.find(Categoria.class, 1);

    entityManager.remove(categoriaGerenciada);
    entityManager.persist(categoriaGerenciada);
    entityManager.detach(categoriaGerenciada);
  }
}
