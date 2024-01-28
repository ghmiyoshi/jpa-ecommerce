package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity(name = "notas_fiscais")
public class NotaFiscal extends EntidadeBase {

  @Lob
  @Column(length = 1000)
  private byte[] xml;

  @Column(name = "data_emissao")
  private LocalDateTime dataEmissao;

  @MapsId
  @OneToOne(optional = false)
  @JoinColumn(name = "pedido_id")
  private Pedido pedido;
}
