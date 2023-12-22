package com.algaworks.ecommerce.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
@Entity
@Table(name = "pagamento_boletos")
public class PagamentoBoleto {

  @Id
  private Long id;

  @Column(name = "pedido_id")
  private Long pedidoId;
  private StatusPagamentoEnum status;
  @Column(name = "codigo_barras")
  private String codigoBarras;

}
