package com.algaworks.ecommerce.models;

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
public class ItemPedidoId implements Serializable {

  private Long pedidoId;

  private Long produtoId;
}
