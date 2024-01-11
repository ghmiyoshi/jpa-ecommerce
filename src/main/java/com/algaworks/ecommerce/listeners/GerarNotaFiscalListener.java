package com.algaworks.ecommerce.listeners;

import static java.util.Objects.isNull;

import com.algaworks.ecommerce.models.Pedido;
import com.algaworks.ecommerce.services.NotaFiscalService;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;

public class GerarNotaFiscalListener {

  private NotaFiscalService notaFiscalService = new NotaFiscalService();

  @PrePersist
  @PreUpdate
  public void gerar(final Pedido pedido) {
    if (pedido.isPago() && isNull(pedido.getNotaFiscalId())) {
      notaFiscalService.gerar(pedido);
    }
  }
}
