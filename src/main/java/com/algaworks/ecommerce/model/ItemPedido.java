package com.algaworks.ecommerce.model;

import jakarta.persistence.Column;
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
  @Column(name = "pedido_id")
  private Long pedidoId;
  @Column(name = "produto_id")
  private Long produtoId;
  @Column(name = "preco_produto")
  private BigDecimal precoProduto;
  private int quantidade;

}
