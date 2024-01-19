package com.algaworks.ecommerce.mapeamentoavancado;

import static org.junit.jupiter.api.Assertions.assertFalse;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Produto;
import java.util.Arrays;
import org.junit.jupiter.api.Test;

class ElementCollectionTest extends EntityManagerTest {

  @Test
  void aplicarTags() {
    entityManager.getTransaction().begin();

    Produto produto = entityManager.find(Produto.class, 1);
    produto.setTags(Arrays.asList("ebook", "livro-digital"));

    entityManager.getTransaction().commit();

    entityManager.clear();

    Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
    assertFalse(produtoVerificacao.getTags().isEmpty());
  }
}
