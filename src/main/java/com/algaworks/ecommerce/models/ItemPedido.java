package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import java.math.BigDecimal;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(of = {"pedidoId", "produtoId"})
@IdClass(ItemPedidoId.class)
@Entity(name = "item_pedidos")
public class ItemPedido {

  @Id
  @Column(name = "pedido_id")
  private Long pedidoId;

  @Id
  @Column(name = "produto_id")
  private Long produtoId;

  @ManyToOne(optional = false)
  @JoinColumn(name = "pedido_id", insertable = false, updatable = false)
  private Pedido pedido;

  @ManyToOne(optional = false)
  @JoinColumn(name = "produto_id", insertable = false, updatable = false)
  private Produto produto;

  @Column(name = "preco_produto")
  private BigDecimal precoProduto;

  private int quantidade;
}
