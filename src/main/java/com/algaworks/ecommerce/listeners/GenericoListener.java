package com.algaworks.ecommerce.listeners;

import jakarta.persistence.PostLoad;

public class GenericoListener {

  @PostLoad
  public void logCarregamento(final Object obj) {
    System.out.println("Entidade " + obj.getClass().getSimpleName() + " foi carregada");
  }
}
