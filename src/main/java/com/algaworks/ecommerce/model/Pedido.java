package com.algaworks.ecommerce.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
@Entity(name = "pedidos")
public class Pedido {

  @Id
  private Long id;
  private LocalDateTime dataPedido;
  private LocalDateTime dataConclusao;
  private Long notaFiscalId;
  private BigDecimal total;
  private StatusPedidoEnum status;

}
