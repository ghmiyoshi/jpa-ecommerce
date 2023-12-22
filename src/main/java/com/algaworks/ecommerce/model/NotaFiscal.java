package com.algaworks.ecommerce.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import java.time.LocalDateTime;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
@Entity(name = "notas_fiscais")
public class NotaFiscal {

  @Id
  private Long id;
  @Column(name = "pedido_id")
  private Long pedidoId;
  private String xml;
  @Column(name = "data_emissao")
  private LocalDateTime dataEmissao;
}
