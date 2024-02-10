package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "notas_fiscais", uniqueConstraints =
@UniqueConstraint(name = "unq_pedido_id", columnNames = "pedido_id"))
public class NotaFiscal extends EntidadeBase {

  @Lob
  @Column(length = 1000, nullable = false)
  private byte[] xml;

  @Column(name = "data_emissao", nullable = false)
  private LocalDateTime dataEmissao;

  @MapsId
  @OneToOne(optional = false)
  @JoinColumn(name = "pedido_id", nullable = false,
      foreignKey = @ForeignKey(name = "fk_nota_fiscal_pedido"))
  private Pedido pedido;
}
