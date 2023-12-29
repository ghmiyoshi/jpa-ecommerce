package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(of = "id")
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
  @ManyToOne
  @JoinColumn(name = "cliente_id")
  private Cliente cliente;
  @OneToMany(mappedBy = "pedido")
  private List<ItemPedido> itens;

  @OneToOne(mappedBy = "pedido")
  private PagamentoCartao pagamentoCartao;
}
