package com.algaworks.ecommerce.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
@Entity(name = "pagamento_boletos")
public class PagamentoBoleto {

  @Id
  private Long id;
  private Long pedidoId;
  private StatusPagamentoEnum status;
  private String codigoBarras;

}
