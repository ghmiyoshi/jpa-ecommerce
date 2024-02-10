package com.algaworks.ecommerce.models;

import jakarta.persistence.DiscriminatorColumn;
import jakarta.persistence.DiscriminatorType;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@DiscriminatorColumn(name = "tipo_pagamento", discriminatorType = DiscriminatorType.STRING)
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@Entity
@Table(name = "pagamentos")
public abstract class Pagamento extends EntidadeBase {

  @MapsId
  @OneToOne(optional = false)
  @JoinColumn(name = "pedido_id", nullable = false,
      foreignKey = @ForeignKey(name = "fk_pagamento_pedido"))
  private Pedido pedido;

  @Enumerated(EnumType.STRING)
  private StatusPagamentoEnum status;
}
