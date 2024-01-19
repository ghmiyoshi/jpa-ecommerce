package com.algaworks.ecommerce.mapeamentoavancado;

import static com.algaworks.ecommerce.models.TipoContatoEnum.COMERCIAL;
import static com.algaworks.ecommerce.models.TipoContatoEnum.RESIDENCIAL;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Atributo;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.Produto;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

class ElementCollectionTest extends EntityManagerTest {

  @Test
  void aplicarTags() {
    entityManager.getTransaction().begin();

    final var produto = entityManager.find(Produto.class, 1);
    produto.setTags(List.of("ebook", "livro-digital"));

    entityManager.getTransaction().commit();
    entityManager.clear();

    final var produtoVerificacao = entityManager.find(Produto.class, produto.getId());

    assertFalse(produtoVerificacao.getTags().isEmpty());
  }

  @Test
  void aplicarAtributos() {
    entityManager.getTransaction().begin();

    final var produto = entityManager.find(Produto.class, 1);
    produto.setAtributos(List.of(new Atributo("tela", "320x600"), new Atributo("cor", "preto")));

    entityManager.getTransaction().commit();
    entityManager.clear();

    final var produtoVerificacao = entityManager.find(Produto.class, produto.getId());

    assertFalse(produtoVerificacao.getAtributos().isEmpty());
  }

  @Test
  void aplicarContatos() {
    entityManager.getTransaction().begin();

    final var cliente = entityManager.find(Cliente.class, 1);
    cliente.setContatos(Map.of(RESIDENCIAL, "11 99999-9999", COMERCIAL, "11 88888-8888"));

    entityManager.getTransaction().commit();
    entityManager.clear();

    final var clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());

    assertEquals("11 99999-9999", clienteVerificacao.getContatos().get(RESIDENCIAL));
  }
}
