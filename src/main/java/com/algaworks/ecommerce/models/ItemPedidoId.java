package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = {"pedidoId", "produtoId"})
@Embeddable
public class ItemPedidoId implements Serializable {

  @Column(name = "pedido_id")
  private Long pedidoId;

  @Column(name = "produto_id")
  private Long produtoId;
}
