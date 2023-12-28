package com.algaworks.ecommerce.relacionamentos;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Categoria;
import org.junit.jupiter.api.Test;

class AutoRelacionamentoTest extends EntityManagerTest {

  @Test
  void verificarRelacionamento() {
    final var categoriaPai = new Categoria();
    categoriaPai.setNome("Eletrônicos");

    final var categoria = new Categoria();
    categoria.setNome("Celulares");
    categoria.setCategoriaPai(categoriaPai);

    entityManager.getTransaction().begin();
    entityManager.persist(categoriaPai);
    entityManager.persist(categoria);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var categoriaVerificacao = entityManager.find(Categoria.class, categoria.getId());

    assertNotNull(categoriaVerificacao.getCategoriaPai());

    final var categoriaPaiVerificacao = entityManager.find(Categoria.class, categoriaPai.getId());

    assertFalse(categoriaPaiVerificacao.getCategorias().isEmpty());
  }
}
