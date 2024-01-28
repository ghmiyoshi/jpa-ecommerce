package com.algaworks.ecommerce.models;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "pagamentos")
public abstract class Pagamento extends EntidadeBase {

  @MapsId
  @OneToOne(optional = false)
  @JoinColumn(name = "pedido_id")
  private Pedido pedido;

  @Enumerated(EnumType.STRING)
  private StatusPagamentoEnum status;

  
}
