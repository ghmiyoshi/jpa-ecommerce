package com.algaworks.ecommerce.models;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.PAGO;
import static java.util.Objects.nonNull;

import com.algaworks.ecommerce.listeners.GenericoListener;
import com.algaworks.ecommerce.listeners.GerarNotaFiscalListener;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EntityListeners({GerarNotaFiscalListener.class, GenericoListener.class})
@Table(name = "pedidos", uniqueConstraints =
@UniqueConstraint(name = "unq_cliente_id", columnNames = "cliente_id"))
@Entity
public class Pedido extends EntidadeBase {

  @Column(name = "data_pedido")
  private LocalDateTime dataPedido;

  @Column(name = "data_conclusao")
  private LocalDateTime dataConclusao;

  @Column(name = "nota_fiscal_id")
  private Long notaFiscalId;

  @Column(precision = 19, scale = 2, nullable = false)
  private BigDecimal total;

  @Column(length = 30, nullable = false)
  @Enumerated(EnumType.STRING)
  private StatusPedidoEnum status;

  @Embedded
  private Endereco enderecoEntrega;

  /* Adicionando optional forca a execucao de um inner join que é um pouco mais performático */
  @ManyToOne(optional = false)
  @JoinColumn(name = "cliente_id", nullable = false,
      foreignKey = @ForeignKey(name = "fk_pedidos_clientes"))
  private Cliente cliente;

  @OneToMany(mappedBy = "pedido", cascade = CascadeType.PERSIST)
  private List<ItemPedido> itens;

  @OneToOne(mappedBy = "pedido")
  private Pagamento pagamento;

  @OneToOne(mappedBy = "pedido")
  private NotaFiscal notaFiscal;

  @PrePersist
  public void prePersist() {
    this.setDataCriacao(LocalDateTime.now());
    this.calcularTotal();
  }

  @PreUpdate
  public void preUpdate() {
    this.setDataUltimaAtualizacao(LocalDateTime.now());
    this.calcularTotal();
  }

  private void calcularTotal() {
    if (nonNull(itens)) {
      total = itens.stream().map(ItemPedido::getPrecoProduto)
          .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
  }

  public boolean isPago() {
    return PAGO.equals(status);
  }
}
