package com.algaworks.ecommerce.model;

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
  private Long pedidoId;
  private String xml;
  private LocalDateTime dataEmissao;

}
