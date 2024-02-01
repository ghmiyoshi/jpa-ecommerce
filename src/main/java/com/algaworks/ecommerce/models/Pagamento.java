package com.algaworks.ecommerce.models;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Entity
public abstract class Pagamento extends EntidadeBase {

  @MapsId
  @OneToOne(optional = false)
  @JoinColumn(name = "pedido_id")
  private Pedido pedido;

  @Enumerated(EnumType.STRING)
  private StatusPagamentoEnum status;
}
