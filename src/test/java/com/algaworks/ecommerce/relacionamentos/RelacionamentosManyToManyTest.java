package com.algaworks.ecommerce.relacionamentos;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Categoria;
import com.algaworks.ecommerce.models.Produto;
import java.util.List;
import org.junit.jupiter.api.Test;

class RelacionamentosManyToManyTest extends EntityManagerTest {

  @Test
  void verificarRelacionamentoNoOwner() {
    final var produto = entityManager.find(Produto.class, 1);
    final var categoria = entityManager.find(Categoria.class, 1);

    entityManager.getTransaction().begin();
    categoria.setProdutos(List.of(produto));
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var categoriaVerificacao = entityManager.find(Categoria.class, categoria.getId());

    assertTrue(categoriaVerificacao.getProdutos().isEmpty());
  }

  @Test
  void verificarRelacionamentoOwner() {
    final var produto = entityManager.find(Produto.class, 1);
    final var categoria = entityManager.find(Categoria.class, 1);

    entityManager.getTransaction().begin();
    produto.setCategorias(List.of(categoria));
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var categoriaVerificacao = entityManager.find(Categoria.class, categoria.getId());

    assertFalse(categoriaVerificacao.getProdutos().isEmpty());
  }
}
