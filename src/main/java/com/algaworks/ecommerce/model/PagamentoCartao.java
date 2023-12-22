package com.algaworks.ecommerce.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import java.math.BigDecimal;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
@Entity(name = "pagamento_cartoes")
public class PagamentoCartao {

  @Id
  private Long id;
  @Column(name = "pedido_id")
  private Long pedidoId;
  private StatusPagamentoEnum status;
  private String numero;

}
