package com.algaworks.ecommerce.services;

import com.algaworks.ecommerce.models.Pedido;

public class NotaFiscalService {

  public void gerar(final Pedido pedido) {
    System.out.println("Gerando nota para o pedido: " + pedido.getId());
  }
}
