package com.algaworks.ecommerce.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
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
  @Enumerated(EnumType.STRING)
  private StatusPagamentoEnum status;
  private String numero;
}
