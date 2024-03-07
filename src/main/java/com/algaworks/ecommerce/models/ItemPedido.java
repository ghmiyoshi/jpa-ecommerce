package com.algaworks.ecommerce.models;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.PrePersist;
import java.math.BigDecimal;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(of = {"pedidoId", "produtoId"})
@Entity(name = "item_pedidos")
public class ItemPedido {

  @EmbeddedId
  private ItemPedidoId id;

  @MapsId("pedidoId")
  @ManyToOne(optional = false, cascade = CascadeType.MERGE)
  @JoinColumn(name = "pedido_id", nullable = false,
      foreignKey = @ForeignKey(name = "fk_item_pedido_pedido"))
  private Pedido pedido;

  @MapsId("produtoId")
  @ManyToOne(optional = false)
  @JoinColumn(name = "produto_id", nullable = false,
      foreignKey = @ForeignKey(name = "fk_item_pedido_produto"))
  private Produto produto;

  @Column(name = "preco_produto", nullable = false)
  private BigDecimal precoProduto;

  @Column(nullable = false)
  private int quantidade;

  @PrePersist
  private void prePersist() {
    this.setId(new ItemPedidoId());
  }
}
