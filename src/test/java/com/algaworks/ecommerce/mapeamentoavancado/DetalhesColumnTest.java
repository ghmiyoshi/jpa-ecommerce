package com.algaworks.ecommerce.mapeamentoavancado;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Produto;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import org.junit.jupiter.api.Test;

class DetalhesColumnTest extends EntityManagerTest {

  @Test
  void impedirInsercaoDaColunaAtualizacao() {
    final var produto = new Produto();
    produto.setNome("Teclado para smartphone");
    produto.setDescricao("O mais confortável");
    produto.setPreco(BigDecimal.ONE);
    produto.setDataCriacao(LocalDateTime.now());
    produto.setDataUltimaAtualizacao(LocalDateTime.now());

    entityManager.getTransaction().begin();
    entityManager.persist(produto);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var produtoVerificacao = entityManager.find(Produto.class, produto.getId());

    assertNotNull(produtoVerificacao.getDataCriacao());
    assertNull(produtoVerificacao.getDataUltimaAtualizacao());
  }

  @Test
  void impedirAtualizacaoDaColunaCriacao() {
    entityManager.getTransaction().begin();

    final var produto = entityManager.find(Produto.class, 1);
    produto.setPreco(BigDecimal.TEN);
    produto.setDataCriacao(LocalDateTime.now());
    produto.setDataUltimaAtualizacao(LocalDateTime.now());

    entityManager.getTransaction().commit();

    entityManager.clear();

    final var produtoVerificacao = entityManager.find(Produto.class, produto.getId());

    assertNotEquals(produto.getDataCriacao().truncatedTo(ChronoUnit.SECONDS),
        produtoVerificacao.getDataCriacao().truncatedTo(ChronoUnit.SECONDS));
    assertEquals(produto.getDataUltimaAtualizacao().truncatedTo(ChronoUnit.SECONDS),
        produtoVerificacao.getDataUltimaAtualizacao().truncatedTo(ChronoUnit.SECONDS));
  }
}
