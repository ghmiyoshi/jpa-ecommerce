package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DiscriminatorValue("boleto")
@Table(name = "pagamentos_boletos")
public class PagamentoBoleto extends Pagamento {

  @Column(name = "codigo_barras")
  private String codigoBarras;
}
