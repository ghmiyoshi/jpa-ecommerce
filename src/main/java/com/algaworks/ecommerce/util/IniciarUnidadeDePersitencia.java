package com.algaworks.ecommerce.util;

import com.algaworks.ecommerce.model.Produto;
import jakarta.persistence.Persistence;

public class IniciarUnidadeDePersitencia {

  public static void main(String[] args) {
    final var entityManagerFactory = Persistence.createEntityManagerFactory("Ecommerce-PU");
    final var entityManager = entityManagerFactory.createEntityManager();

    final var produto = entityManager.find(Produto.class, 1L);
    System.out.println(produto.getDescricao());

    entityManager.close();
    entityManagerFactory.close();
  }
}
