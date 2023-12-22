package com.algaworks.ecommerce.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
@Entity(name = "item_pedidos")
public class ItemPedido {

  @Id
  private Long id;
  private Long pedidoId;
  private Long produtoId;
  private BigDecimal precoProduto;
  private int quantidade;

}
