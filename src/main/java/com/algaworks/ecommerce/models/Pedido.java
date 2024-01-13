package com.algaworks.ecommerce.models;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.PAGO;
import static java.util.Objects.nonNull;

import com.algaworks.ecommerce.listeners.GenericoListener;
import com.algaworks.ecommerce.listeners.GerarNotaFiscalListener;
import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(of = "id")
@EntityListeners({GerarNotaFiscalListener.class, GenericoListener.class})
@Entity(name = "pedidos")
public class Pedido {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  @Column(name = "data_pedido")
  private LocalDateTime dataPedido;
  @Column(name = "data_conclusao")
  private LocalDateTime dataConclusao;
  @Column(name = "nota_fiscal_id")
  private Long notaFiscalId;
  private BigDecimal total;
  @Enumerated(EnumType.STRING)
  private StatusPedidoEnum status;
  @Embedded
  private Endereco enderecoEntrega;

  /* Adicionando optional forca a execucao de um inner join que é um pouco mais performático */
  @ManyToOne(optional = false)
  @JoinColumn(name = "cliente_id")
  private Cliente cliente;
  @OneToMany(mappedBy = "pedido")
  private List<ItemPedido> itens;

  @OneToOne(mappedBy = "pedido")
  private PagamentoCartao pagamentoCartao;

  @OneToOne(mappedBy = "pedido")
  private NotaFiscal notaFiscal;

  @Column(name = "data_criacao", updatable = false)
  private LocalDateTime dataCriacao;

  @Column(name = "data_ultima_atualizacao", insertable = false)
  private LocalDateTime dataUltimaAtualizacao;

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
